/// 인증 상태를 나타내는 열거형
enum AuthState {
  /// 앱 초기화 중
  initial,

  /// 로그인 필요
  unauthenticated,

  /// 프로필 설정 필요
  needsOnboarding,

  /// 완전히 인증됨
  authenticated,
}
