import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_provider.dart' as app;
import '../../domain/entities/auth_state.dart' as app;
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

// DataSource provider
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(Supabase.instance.client);
}

// Repository provider
@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

// Current user provider
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  UserProfile? build() => null;

  void setUser(UserProfile? user) {
    state = user;
  }
}

// Auth state notifier
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  app.AuthState build() => app.AuthState.initial;

  Future<void> checkAuthState() async {
    final repository = ref.read(authRepositoryProvider);
    final authState = await repository.checkAuthState();
    state = authState;

    if (authState == app.AuthState.authenticated) {
      ref.read(currentUserProvider.notifier).setUser(repository.currentUser);
    }
  }

  Future<void> signIn(app.AuthProvider provider) async {
    try {
      final repository = ref.read(authRepositoryProvider);
      final profile = await repository.signInWithProvider(provider);

      ref.read(currentUserProvider.notifier).setUser(profile);

      if (profile.isProfileComplete) {
        state = app.AuthState.authenticated;
      } else {
        state = app.AuthState.needsOnboarding;
      }
    } catch (e) {
      state = app.AuthState.unauthenticated;
      rethrow;
    }
  }

  Future<void> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    ref.read(currentUserProvider.notifier).setUser(null);
    state = app.AuthState.unauthenticated;
  }

  void completeOnboarding(UserProfile profile) {
    ref.read(currentUserProvider.notifier).setUser(profile);
    state = app.AuthState.authenticated;
  }
}

// Legacy provider name for compatibility
final authStateProvider = authStateNotifierProvider;
