# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

RunningMate - 맞춤형 러닝 코스를 추천해주는 스마트 러닝 앱 (Flutter)

## Build & Development Commands

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (freezed, json_serializable, riverpod_generator)
dart run build_runner build --delete-conflicting-outputs

# 코드 생성 (watch 모드)
dart run build_runner watch --delete-conflicting-outputs

# 앱 실행
flutter run

# 정적 분석
flutter analyze

# 테스트 실행
flutter test

# 단일 테스트 파일 실행
flutter test test/widget_test.dart
```

## Architecture

Clean Architecture + Feature-First 구조를 따릅니다:

```
lib/
├── main.dart              # 앱 진입점, 환경 설정 로드
├── app/
│   ├── app.dart           # MaterialApp 설정
│   └── routes.dart        # go_router 라우팅 설정
├── core/
│   ├── constants/         # 앱 전역 상수 (colors, sizes, strings)
│   ├── theme/             # Material 3 테마 설정
│   ├── services/          # 공통 서비스 (예정)
│   └── utils/             # 유틸리티 함수 (예정)
├── features/              # 기능별 모듈
│   ├── auth/              # 인증
│   ├── course/            # 러닝 코스
│   ├── home/              # 홈 화면
│   ├── profile/           # 프로필
│   └── tracking/          # 러닝 트래킹
├── data/                  # 공유 데이터 레이어
└── shared/                # 공유 모델/위젯
```

각 feature는 다음 구조를 가집니다:
- `data/` - datasources, models, repositories 구현
- `domain/` - entities, usecases, repository 인터페이스
- `presentation/` - screens, widgets, providers

## Key Technologies

- **State Management**: Riverpod (flutter_riverpod + riverpod_generator)
- **Navigation**: go_router
- **Backend**: Supabase (supabase_flutter)
- **Maps**: Mapbox (mapbox_maps_flutter)
- **Location**: geolocator + permission_handler
- **Code Generation**: freezed, json_serializable, build_runner

## Environment Setup

`.env` 파일에 다음 키 필요:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `MAPBOX_ACCESS_TOKEN`

## Conventions

- 테마 색상은 `AppColors` 클래스 사용
- 간격/크기는 `AppSizes` 상수 사용
- 문자열은 `AppStrings` 클래스에서 관리
- 폰트는 Google Fonts의 Inter 사용

## Claude Code Plugins

### Git & 코드 관리

| 명령어 | 설명 |
|--------|------|
| `/commit` | Git 커밋 생성 |
| `/commit-push-pr` | 커밋 → 푸시 → PR 생성까지 한번에 |
| `/clean_gone` | 삭제된 원격 브랜치의 로컬 브랜치 정리 |
| `/code-review` | PR 코드 리뷰 |

### 개발 워크플로우

| 명령어 | 설명 |
|--------|------|
| `/feature-dev` | 코드베이스 이해 및 아키텍처 중심 기능 개발 가이드 |
| `/frontend-design` | 고품질 프론트엔드 인터페이스 생성 |
| `/new-sdk-app` | Claude Agent SDK 앱 생성 및 설정 |

### Superpowers (개발 방법론)

| 명령어 | 설명 |
|--------|------|
| `/brainstorming` | 기능 구현 전 요구사항/디자인 탐색 |
| `/writing-plans` | 멀티스텝 작업 계획 작성 |
| `/executing-plans` | 작성된 계획 실행 |
| `/test-driven-development` | TDD 방식으로 기능 구현 |
| `/systematic-debugging` | 체계적 디버깅 |
| `/using-git-worktrees` | Git worktree로 격리된 작업 환경 생성 |
| `/dispatching-parallel-agents` | 병렬 에이전트로 독립 작업 수행 |
| `/requesting-code-review` | 코드 리뷰 요청 |
| `/verification-before-completion` | 완료 전 검증 |

### Figma 연동

| 명령어 | 설명 |
|--------|------|
| `/implement-design` | Figma 디자인을 코드로 변환 |
| `/code-connect-components` | Figma 컴포넌트와 코드 연결 |
| `/create-design-system-rules` | 디자인 시스템 규칙 생성 |

### HuggingFace

| 명령어 | 설명 |
|--------|------|
| `/hugging-face-tool-builder` | HF API 활용 도구/스크립트 생성 |
| `/hugging-face-datasets` | HF 데이터셋 생성/관리 |
| `/hugging-face-model-trainer` | TRL로 모델 학습/파인튜닝 |
| `/hugging-face-jobs` | HF Jobs 인프라에서 작업 실행 |
| `/hugging-face-cli` | HF CLI 작업 수행 |

### 자동화

| 명령어 | 설명 |
|--------|------|
| `/ralph-loop` | 현재 세션에서 Ralph Loop 시작 (자동 반복 작업) |
| `/cancel-ralph` | Ralph Loop 취소 |

### 기타 플러그인

| 플러그인 | 설명 |
|----------|------|
| `github` | GitHub API 연동 (이슈, PR 등) |
| `supabase` | Supabase 연동 |
| `pyright-lsp` | Python 코드 인텔리전스 (자동 활성화) |
| `context7` | 컨텍스트 관리 |
| `learning-output-style` | 학습 친화적 출력 스타일 |
| `security-guidance` | 보안 가이드라인 |

### 자주 사용하는 워크플로우

```bash
# 기능 개발 시작
/brainstorming

# 계획 작성 후 실행
/writing-plans
/executing-plans

# 코드 작성 완료 후
/commit
# 또는 한번에
/commit-push-pr

# PR 리뷰
/code-review
```
