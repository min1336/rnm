import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/auth_provider.dart' as app;
import '../../domain/entities/auth_state.dart' as app;
import '../models/user_profile_model.dart';

abstract class AuthRemoteDataSource {
  Stream<app.AuthState> get authStateStream;
  Session? get currentSession;
  User? get currentUser;

  Future<User> signInWithProvider(app.AuthProvider provider);
  Future<void> signOut();
  Future<UserProfileModel?> getProfile(String userId);
  Future<UserProfileModel> upsertProfile(UserProfileModel profile);
  Future<bool> isNicknameAvailable(String nickname);
  Future<void> requestAccountDeletion(String userId);
  Future<void> cancelAccountDeletion(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSourceImpl(this._supabase);

  @override
  Stream<app.AuthState> get authStateStream =>
      _supabase.auth.onAuthStateChange.map((event) => event.session != null
          ? app.AuthState.authenticated
          : app.AuthState.unauthenticated);

  @override
  Session? get currentSession => _supabase.auth.currentSession;

  @override
  User? get currentUser => _supabase.auth.currentUser;

  @override
  Future<User> signInWithProvider(app.AuthProvider provider) async {
    final oAuthProvider = switch (provider) {
      app.AuthProvider.google => OAuthProvider.google,
      app.AuthProvider.apple => OAuthProvider.apple,
      app.AuthProvider.kakao => OAuthProvider.kakao,
    };

    final response = await _supabase.auth.signInWithOAuth(
      oAuthProvider,
      redirectTo: 'com.runningmate.app://callback',
    );

    if (!response) {
      throw Exception('OAuth sign in failed');
    }

    // Wait for auth state change
    await _supabase.auth.onAuthStateChange.firstWhere(
      (event) => event.session != null,
    );

    return _supabase.auth.currentUser!;
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<UserProfileModel?> getProfile(String userId) async {
    final response = await _supabase
        .from('user_profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserProfileModel.fromJson(response);
  }

  @override
  Future<UserProfileModel> upsertProfile(UserProfileModel profile) async {
    final response = await _supabase
        .from('user_profiles')
        .upsert(profile.toJson())
        .select()
        .single();

    return UserProfileModel.fromJson(response);
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    final response = await _supabase
        .from('user_profiles')
        .select('id')
        .eq('nickname', nickname)
        .maybeSingle();

    return response == null;
  }

  @override
  Future<void> requestAccountDeletion(String userId) async {
    await _supabase.from('user_profiles').update({
      'is_deleted': true,
      'deletion_requested_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  @override
  Future<void> cancelAccountDeletion(String userId) async {
    await _supabase.from('user_profiles').update({
      'is_deleted': false,
      'deletion_requested_at': null,
    }).eq('id', userId);
  }
}
