# 러닝 트래킹 시스템 설계

> 작성일: 2026-01-29
> 상태: 승인됨

## 개요

RunningMate 앱의 핵심 기능인 GPS 기반 실시간 러닝 트래킹 시스템 설계 문서입니다.

### 핵심 요구사항

- 실시간 피드백 + 완료 후 상세 기록
- 커스텀 가능한 메인 화면 (사용자가 표시 항목 선택)
- 자동 백그라운드 트래킹 (러닝 시작 시 활성화, 종료 시 해제)
- 풀 코칭 (구간 알림 + 목표 코칭 + 격려 메시지)
- 자동 + 수동 일시정지
- 로컬 우선 저장 + 백그라운드 서버 동기화
- 균형 잡힌 GPS (2-3초 간격)
- 코스 경로 안내 + 완주 기록 연결

---

## 1. 데이터 모델

### RunSession (러닝 세션)

```dart
class RunSession {
  String id;
  String userId;
  String? courseId;              // 코스 러닝이면 ID, 자유 러닝이면 null

  // 시간 정보
  DateTime startedAt;
  DateTime? endedAt;
  int totalSeconds;              // 순수 러닝 시간 (일시정지 제외)
  int elapsedSeconds;            // 총 경과 시간 (일시정지 포함)

  // 거리/페이스
  double distanceMeters;
  double avgPaceSecondsPerKm;

  // 경로 데이터
  List<TrackPoint> trackPoints;

  // 구간 데이터
  List<Segment> segments;        // 1km 단위 구간

  // 추가 지표
  int? calories;
  double? elevationGainMeters;
  int? avgCadence;               // 분당 걸음 수

  // 상태
  RunStatus status;              // running, paused, completed, discarded
}
```

### TrackPoint (GPS 포인트)

```dart
class TrackPoint {
  double latitude;
  double longitude;
  double? altitude;
  DateTime timestamp;
  double? speedMps;              // meters per second
  bool isPaused;                 // 일시정지 중 기록된 포인트
}
```

### Segment (1km 구간)

```dart
class Segment {
  int index;                     // 0, 1, 2... (0 = 첫 1km)
  int durationSeconds;
  double paceSecondsPerKm;
  double? elevationChange;
  DateTime startedAt;
  DateTime endedAt;
}
```

### RunStatus (상태)

```dart
enum RunStatus {
  ready,      // 시작 전
  running,    // 러닝 중
  paused,     // 일시정지
  completed,  // 완료
  discarded,  // 취소/삭제
}
```

---

## 2. 서비스 아키텍처

### 전체 구조

```
┌─────────────────────────────────────────────────────────┐
│                    TrackingController                    │
│              (상태 관리 + 서비스 조율)                    │
└─────────────────┬───────────────────────────────────────┘
                  │
    ┌─────────────┼─────────────┬─────────────┐
    ▼             ▼             ▼             ▼
┌────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│Location│  │ Tracking │  │ Coaching │  │   Sync   │
│Service │  │  Engine  │  │ Service  │  │ Service  │
└────────┘  └──────────┘  └──────────┘  └──────────┘
    │             │             │             │
    ▼             ▼             ▼             ▼
  GPS 수집     계산/분석      음성 출력     저장/동기화
```

### 각 서비스 책임

| 서비스 | 책임 |
|--------|------|
| **LocationService** | GPS 권한 요청, 위치 스트림 관리, 백그라운드 트래킹, 자동 일시정지 감지 |
| **TrackingEngine** | 거리 계산, 페이스 계산, 구간 분리, 칼로리/고도 계산 |
| **CoachingService** | TTS 음성 출력, 구간 알림, 목표 비교 알림, 격려 메시지 |
| **SyncService** | 로컬 DB 저장, Supabase 동기화, 오프라인 큐 관리 |
| **TrackingController** | 위 서비스들 조율, UI 상태 관리, 시작/정지/완료 처리 |

### 데이터 흐름

```
GPS 신호 수신
    │
    ▼
LocationService (위치 스트림 발행)
    │
    ▼
TrackingEngine (거리/페이스 계산)
    │
    ├──▶ TrackingController (UI 상태 업데이트)
    │
    ├──▶ CoachingService (구간 완료 시 음성)
    │
    └──▶ SyncService (주기적 로컬 저장)
```

---

## 3. LocationService 상세

### 핵심 기능

```dart
abstract class LocationService {
  // 권한 및 설정
  Future<bool> requestPermission();
  Future<bool> checkGpsEnabled();

  // 위치 스트림
  Stream<TrackPoint> get locationStream;

  // 백그라운드 제어
  Future<void> startBackgroundTracking();
  Future<void> stopBackgroundTracking();

  // 상태
  bool get isTracking;
}
```

### 자동 일시정지 로직

```dart
class AutoPauseDetector {
  static const double pauseSpeedThreshold = 0.5;  // m/s (약 1.8km/h)
  static const Duration pauseDelay = Duration(seconds: 5);

  // 5초간 0.5m/s 이하면 자동 일시정지
  // 1m/s 이상 감지되면 자동 재개
}
```

### GPS 설정

| 항목 | 값 |
|------|-----|
| 수집 간격 | 2-3초 |
| 정확도 | high (GPS 우선) |
| 거리 필터 | 5m (5m 이상 이동 시만 업데이트) |
| 백그라운드 | foreground service + notification |

---

## 4. TrackingEngine 상세

### 핵심 기능

```dart
abstract class TrackingEngine {
  // 실시간 계산
  void addTrackPoint(TrackPoint point);

  // 현재 상태
  RunSessionSnapshot get currentSnapshot;

  // 구간 완료 이벤트
  Stream<Segment> get segmentCompletedStream;

  // 리셋
  void reset();
}
```

### 거리 계산

```dart
class DistanceCalculator {
  // Haversine 공식으로 두 GPS 좌표 간 거리 계산
  double calculateDistance(TrackPoint a, TrackPoint b);

  // 누적 거리 (유효한 포인트만)
  // - 일시정지 중 포인트 제외
  // - 5m 미만 이동은 노이즈로 간주
  // - 비정상 점프 (100m 이상 순간 이동) 필터링
}
```

### 페이스 계산

```dart
class PaceCalculator {
  // 현재 페이스 (최근 10초 평균)
  double getCurrentPace(List<TrackPoint> recentPoints);

  // 평균 페이스 (전체)
  double getAveragePace(double totalMeters, int totalSeconds);

  // 구간 페이스 (1km 단위)
  double getSegmentPace(Segment segment);
}
```

### 구간 분리 로직

```dart
class SegmentSplitter {
  static const double segmentDistance = 1000.0;  // 1km

  // 1km 도달 시 구간 완료 이벤트 발행
  // 구간 정보: 소요 시간, 페이스, 고도 변화
}
```

### 추가 지표 계산

| 지표 | 계산 방식 |
|------|----------|
| 칼로리 | MET × 체중(kg) × 시간(h) × 1.05 |
| 고도 상승 | 연속된 양수 고도 변화 합계 (노이즈 필터 2m) |
| 케이던스 | 걸음 센서 사용 또는 GPS 기반 추정 |

### 실시간 스냅샷

```dart
class RunSessionSnapshot {
  Duration elapsed;           // 경과 시간
  Duration runningTime;       // 순수 러닝 시간
  double distanceMeters;
  double currentPaceSecPerKm;
  double avgPaceSecPerKm;
  int completedSegments;
  Segment? currentSegment;
  int? calories;
  double? elevationGain;

  // 목표 대비 (설정된 경우)
  double? targetPaceSecPerKm;
  PaceStatus? paceStatus;     // ahead, onTarget, behind
}
```

---

## 5. CoachingService 상세

### 핵심 기능

```dart
abstract class CoachingService {
  // 음성 출력
  Future<void> speak(String message);

  // 이벤트 기반 코칭
  void onSegmentCompleted(Segment segment, RunSessionSnapshot snapshot);
  void onPaceStatusChanged(PaceStatus status);
  void onMilestone(MilestoneType type);

  // 설정
  void setEnabled(bool enabled);
  void setVolume(double volume);  // 0.0 ~ 1.0
}
```

### 음성 메시지 종류

**1. 구간 알림 (1km마다)**
```
"1km 완료, 페이스 5분 30초"
"2km 완료, 페이스 5분 45초, 평균 5분 38초"
"3km 완료, 페이스 5분 20초, 이전 구간보다 10초 빨라졌어요"
```

**2. 목표 코칭 (목표 설정 시)**
```
"좋아요! 목표보다 15초 빠르게 달리고 있어요"
"페이스를 조금 올려주세요, 목표보다 20초 느려요"
"완벽해요! 목표 페이스를 유지하고 있어요"
```

**3. 격려 메시지**
```
"절반 완료! 잘하고 있어요"
"반환점입니다, 화이팅!"
"거의 다 왔어요! 조금만 더 힘내세요"
```

**4. 상태 알림**
```
"러닝을 시작합니다"
"일시정지"
"다시 시작합니다"
"러닝 완료! 수고하셨어요"
```

### 메시지 우선순위

| 우선순위 | 메시지 종류 | 처리 |
|----------|------------|------|
| 1 (최고) | 상태 알림 | 즉시 출력, 다른 메시지 중단 |
| 2 | 구간 완료 | 큐에 추가, 순차 출력 |
| 3 | 목표 코칭 | 구간 알림 후 출력 |
| 4 (최저) | 격려 | 다른 메시지 없을 때만 |

### TTS 설정

```dart
class TtsConfig {
  String language = 'ko-KR';
  double speechRate = 0.9;      // 약간 느리게
  double pitch = 1.0;
  bool speakerOnlyWithHeadphones = false;
}
```

---

## 6. SyncService 상세

### 핵심 기능

```dart
abstract class SyncService {
  // 로컬 저장
  Future<void> saveSession(RunSession session);
  Future<void> saveTrackPoints(List<TrackPoint> points);

  // 서버 동기화
  Future<void> syncToServer(String sessionId);
  Future<void> syncPendingSessions();

  // 조회
  Future<RunSession?> getSession(String id);
  Future<List<RunSession>> getRecentSessions({int limit = 20});

  // 상태
  Stream<SyncStatus> get syncStatusStream;
}
```

### 저장 전략

```
러닝 중
    │
    ├── 10초마다 → TrackPoints 로컬 저장 (임시)
    │
    ├── 1km마다 → 구간 데이터 로컬 저장
    │
    └── 완료 시 → 전체 세션 로컬 저장 → 서버 동기화 시도
```

### 동기화 로직

```dart
class SyncStrategy {
  // 1. 러닝 완료 시 즉시 시도
  // 2. 실패 시 → 로컬 큐에 보관
  // 3. 앱 시작 시 → 미동기화 세션 자동 동기화
  // 4. 네트워크 복구 시 → 자동 재시도

  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(minutes: 5);
}
```

### 오프라인 처리

| 상황 | 처리 |
|------|------|
| 러닝 중 오프라인 | 로컬에만 저장, 정상 진행 |
| 완료 시 오프라인 | 로컬 저장 완료, "동기화 대기 중" 표시 |
| 네트워크 복구 | 자동 백그라운드 동기화 |
| 동기화 실패 | 재시도 후 실패 시 수동 동기화 버튼 제공 |

### Supabase 테이블

```sql
-- 러닝 세션
create table run_sessions (
  id uuid primary key,
  user_id uuid references auth.users(id),
  course_id uuid references courses(id),

  started_at timestamptz not null,
  ended_at timestamptz,
  total_seconds int not null,
  elapsed_seconds int not null,

  distance_meters decimal(10,2) not null,
  avg_pace_seconds_per_km decimal(6,2),

  calories int,
  elevation_gain_meters decimal(6,2),
  avg_cadence int,

  status text not null,
  created_at timestamptz default now()
);

-- GPS 포인트
create table run_track_points (
  id uuid primary key,
  session_id uuid references run_sessions(id),
  latitude decimal(10,7) not null,
  longitude decimal(10,7) not null,
  altitude decimal(6,2),
  timestamp timestamptz not null,
  speed_mps decimal(5,2)
);

-- 구간 데이터
create table run_segments (
  id uuid primary key,
  session_id uuid references run_sessions(id),
  segment_index int not null,
  duration_seconds int not null,
  pace_seconds_per_km decimal(6,2) not null,
  elevation_change decimal(6,2),
  started_at timestamptz,
  ended_at timestamptz
);
```

---

## 7. UI/UX 플로우

### 화면 구성

```
┌─────────────────────────────────────────┐
│           TrackingScreen                │
│  ┌───────────────────────────────────┐  │
│  │        메인 데이터 영역            │  │
│  │     (사용자 커스텀 가능)          │  │
│  │                                   │  │
│  │         12:34 (시간)              │  │
│  │                                   │  │
│  │    3.24km        5'30"            │  │
│  │     거리         페이스            │  │
│  │                                   │  │
│  │   목표 대비: 10초 빠름 ✓          │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ← 스와이프: 구간 정보 | 지도 →        │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │   ⏸️ 일시정지    🛑 종료          │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

### 커스텀 화면 설정

```dart
enum TrackingMetric {
  time,           // 경과 시간
  distance,       // 거리
  currentPace,    // 현재 페이스
  avgPace,        // 평균 페이스
  targetStatus,   // 목표 대비 상태
  calories,       // 칼로리
  elevation,      // 고도
  cadence,        // 케이던스
  segmentPace,    // 현재 구간 페이스
  heartRate,      // 심박수 (연동 시)
}

class TrackingLayout {
  TrackingMetric primaryMetric;      // 가장 크게 표시
  List<TrackingMetric> secondaryMetrics;  // 중간 크기 (최대 4개)
  TrackingMetric? bottomMetric;      // 하단 바
}
```

### 코스 따라가기 모드

- 진행률 표시 (프로그레스 바)
- 남은 거리
- 지도에 현재 위치 + 코스 경로 표시
- 방향 안내 ("300m 앞에서 좌회전")

---

## 8. 러닝 완료 결과 화면

### 포함 내용

- 경로 지도 미리보기
- 요약: 거리, 시간, 평균 페이스, 칼로리, 고도 상승
- 구간별 페이스 그래프 + 테이블
- 고도 변화 차트
- 이전 기록 비교 (평균 페이스 향상/하락)
- 이번 달 누적 거리, 연속 러닝 일수

### 코스 완주 시 추가

- 코스 완주 배지
- 내 기록 vs 코스 평균
- 상위 % 표시
- 코스 평가하기 버튼

### 공유 기능

- 경로 지도 + 주요 지표 이미지 생성
- 인스타그램 스토리, 카카오톡 등 공유

---

## 9. 에러 처리

### GPS 관련

| 상황 | 처리 |
|------|------|
| 권한 거부 | 설정 앱으로 이동 안내 |
| GPS 꺼짐 | GPS 활성화 요청 |
| 신호 불안정 | "GPS 신호 찾는 중" 표시 |
| 비정상 점프 | 해당 포인트 무시 |

### 배터리/시스템

| 상황 | 처리 |
|------|------|
| 배터리 20% 미만 | 알림 + 절전 모드 권유 |
| 배터리 5% 미만 | 자동 저장 + 경고 |
| 앱 킬 | Foreground Service로 방지 |

### 비정상 종료 복구

```dart
class CrashRecovery {
  Future<RunSession?> checkUnfinishedSession();
  // "이전 러닝이 완료되지 않았어요"
  // [이어서 하기] [저장하고 종료] [삭제]
}
```

---

## 10. 테스트 전략

### 우선순위

| 우선순위 | 영역 |
|----------|------|
| 🔴 높음 | DistanceCalculator, PaceCalculator, AutoPauseDetector |
| 🟡 중간 | SegmentSplitter, SyncService |
| 🟢 낮음 | CoachingService, UI 위젯 |

### Mock GPS

```dart
class MockLocationService implements LocationService {
  Stream<TrackPoint> simulateRun({
    required double distanceKm,
    required Duration duration,
  });

  Stream<TrackPoint> simulateWithPause();
  Stream<TrackPoint> simulateGpsLoss();
}
```

---

## 기술 스택

### 클라이언트

| 영역 | 기술 |
|------|------|
| GPS | geolocator + permission_handler |
| 백그라운드 | flutter_background_geolocation |
| TTS | flutter_tts |
| 로컬 DB | Hive 또는 Isar |
| 지도 | Mapbox Maps Flutter |

### 백엔드

- Supabase (PostgreSQL)
- Supabase Realtime (동기화 상태)

---

## 다음 단계

1. Git worktree로 격리된 작업 환경 생성
2. 구현 계획 상세 작성
3. 단계별 구현 진행
