import '../entities/auth_provider.dart';
import '../entities/auth_state.dart' as app;
import '../entities/user_profile.dart';

abstract class AuthRepository {
  /// 현재 인증 상태 스트림
  Stream<app.AuthState> get authStateStream;

  /// 현재 사용자 프로필
  UserProfile? get currentUser;

  /// 로그인 여부
  bool get isLoggedIn;

  /// 소셜 로그인
  Future<UserProfile> signInWithProvider(AuthProvider provider);

  /// 로그아웃
  Future<void> signOut();

  /// 프로필 조회
  Future<UserProfile?> getProfile(String userId);

  /// 프로필 업데이트
  Future<UserProfile> updateProfile(UserProfile profile);

  /// 닉네임 중복 체크
  Future<bool> isNicknameAvailable(String nickname);

  /// 계정 삭제 요청
  Future<void> requestAccountDeletion();

  /// 계정 삭제 취소
  Future<void> cancelAccountDeletion();

  /// 인증 상태 체크
  Future<app.AuthState> checkAuthState();
}
