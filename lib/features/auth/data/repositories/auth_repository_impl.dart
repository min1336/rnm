import '../../domain/entities/auth_provider.dart' as app;
import '../../domain/entities/auth_state.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  UserProfile? _cachedProfile;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<AuthState> get authStateStream =>
      _dataSource.authStateStream.asyncMap((_) => checkAuthState());

  @override
  UserProfile? get currentUser => _cachedProfile;

  @override
  bool get isLoggedIn => _dataSource.currentSession != null;

  @override
  Future<UserProfile> signInWithProvider(app.AuthProvider provider) async {
    final user = await _dataSource.signInWithProvider(provider);

    // Check if profile exists
    var profile = await _dataSource.getProfile(user.id);

    if (profile == null) {
      // Create new profile
      profile = UserProfileModel.fromEntity(
        id: user.id,
        email: user.email ?? '',
        provider: provider,
        createdAt: DateTime.now(),
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
      );
      profile = await _dataSource.upsertProfile(profile);
    }

    _cachedProfile = profile.toEntity();
    return _cachedProfile!;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
    _cachedProfile = null;
  }

  @override
  Future<UserProfile?> getProfile(String userId) async {
    final profile = await _dataSource.getProfile(userId);
    if (profile == null) return null;
    _cachedProfile = profile.toEntity();
    return _cachedProfile;
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async {
    final model = UserProfileModel.fromEntity(
      id: profile.id,
      email: profile.email,
      provider: profile.provider,
      createdAt: profile.createdAt,
      nickname: profile.nickname,
      avatarUrl: profile.avatarUrl,
      weightKg: profile.weightKg,
      goal: profile.goal,
      lastLoginAt: profile.lastLoginAt,
      isDeleted: profile.isDeleted,
      deletionRequestedAt: profile.deletionRequestedAt,
    );

    final updated = await _dataSource.upsertProfile(model);
    _cachedProfile = updated.toEntity();
    return _cachedProfile!;
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) {
    return _dataSource.isNicknameAvailable(nickname);
  }

  @override
  Future<void> requestAccountDeletion() async {
    final userId = _dataSource.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');
    await _dataSource.requestAccountDeletion(userId);
  }

  @override
  Future<void> cancelAccountDeletion() async {
    final userId = _dataSource.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');
    await _dataSource.cancelAccountDeletion(userId);
  }

  @override
  Future<AuthState> checkAuthState() async {
    // 1. Check session
    final session = _dataSource.currentSession;
    if (session == null) return AuthState.unauthenticated;

    // 2. Get user
    final user = _dataSource.currentUser;
    if (user == null) return AuthState.unauthenticated;

    // 3. Get profile
    final profile = await _dataSource.getProfile(user.id);

    // 4. Check profile completion
    if (profile == null || profile.nickname == null) {
      return AuthState.needsOnboarding;
    }

    // 5. Check deletion status
    if (profile.isDeleted) return AuthState.unauthenticated;

    _cachedProfile = profile.toEntity();
    return AuthState.authenticated;
  }
}
