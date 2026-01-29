import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:running_mate/features/auth/data/models/user_profile_model.dart';
import 'package:running_mate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:running_mate/features/auth/domain/entities/auth_provider.dart';
import 'package:running_mate/features/auth/domain/entities/auth_state.dart';
import 'package:running_mate/features/auth/domain/entities/running_goal.dart';
import 'package:running_mate/features/auth/domain/entities/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepositoryImpl', () {
    group('checkAuthState', () {
      test('should return unauthenticated when no session exists', () async {
        when(mockDataSource.currentSession).thenReturn(null);

        final result = await repository.checkAuthState();

        expect(result, AuthState.unauthenticated);
      });

      test('should return unauthenticated when no user exists', () async {
        when(mockDataSource.currentSession).thenReturn(
          supabase.Session(
            accessToken: 'test_token',
            tokenType: 'bearer',
            user: supabase.User(
              id: 'test_user_id',
              appMetadata: {},
              userMetadata: {},
              aud: 'authenticated',
              createdAt: DateTime.now().toIso8601String(),
            ),
          ),
        );
        when(mockDataSource.currentUser).thenReturn(null);

        final result = await repository.checkAuthState();

        expect(result, AuthState.unauthenticated);
      });

      test('should return needsOnboarding when profile is null', () async {
        final testUser = supabase.User(
          id: 'test_user_id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );

        when(mockDataSource.currentSession).thenReturn(
          supabase.Session(
            accessToken: 'test_token',
            tokenType: 'bearer',
            user: testUser,
          ),
        );
        when(mockDataSource.currentUser).thenReturn(testUser);
        when(mockDataSource.getProfile('test_user_id'))
            .thenAnswer((_) async => null);

        final result = await repository.checkAuthState();

        expect(result, AuthState.needsOnboarding);
      });

      test('should return needsOnboarding when nickname is null', () async {
        final testUser = supabase.User(
          id: 'test_user_id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );

        when(mockDataSource.currentSession).thenReturn(
          supabase.Session(
            accessToken: 'test_token',
            tokenType: 'bearer',
            user: testUser,
          ),
        );
        when(mockDataSource.currentUser).thenReturn(testUser);
        when(mockDataSource.getProfile('test_user_id')).thenAnswer(
          (_) async => UserProfileModel(
            id: 'test_user_id',
            email: 'test@example.com',
            nickname: null,
            provider: 'google',
            createdAt: DateTime.now(),
          ),
        );

        final result = await repository.checkAuthState();

        expect(result, AuthState.needsOnboarding);
      });

      test('should return unauthenticated when profile is deleted', () async {
        final testUser = supabase.User(
          id: 'test_user_id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );

        when(mockDataSource.currentSession).thenReturn(
          supabase.Session(
            accessToken: 'test_token',
            tokenType: 'bearer',
            user: testUser,
          ),
        );
        when(mockDataSource.currentUser).thenReturn(testUser);
        when(mockDataSource.getProfile('test_user_id')).thenAnswer(
          (_) async => UserProfileModel(
            id: 'test_user_id',
            email: 'test@example.com',
            nickname: 'TestRunner',
            provider: 'google',
            createdAt: DateTime.now(),
            isDeleted: true,
          ),
        );

        final result = await repository.checkAuthState();

        expect(result, AuthState.unauthenticated);
      });

      test('should return authenticated when profile is complete', () async {
        final testUser = supabase.User(
          id: 'test_user_id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );

        when(mockDataSource.currentSession).thenReturn(
          supabase.Session(
            accessToken: 'test_token',
            tokenType: 'bearer',
            user: testUser,
          ),
        );
        when(mockDataSource.currentUser).thenReturn(testUser);
        when(mockDataSource.getProfile('test_user_id')).thenAnswer(
          (_) async => UserProfileModel(
            id: 'test_user_id',
            email: 'test@example.com',
            nickname: 'TestRunner',
            provider: 'google',
            createdAt: DateTime.now(),
            isDeleted: false,
          ),
        );

        final result = await repository.checkAuthState();

        expect(result, AuthState.authenticated);
      });
    });

    group('isNicknameAvailable', () {
      test('should delegate to datasource and return true', () async {
        when(mockDataSource.isNicknameAvailable('runner'))
            .thenAnswer((_) async => true);

        final result = await repository.isNicknameAvailable('runner');

        expect(result, true);
        verify(mockDataSource.isNicknameAvailable('runner')).called(1);
      });

      test('should delegate to datasource and return false', () async {
        when(mockDataSource.isNicknameAvailable('takenNickname'))
            .thenAnswer((_) async => false);

        final result = await repository.isNicknameAvailable('takenNickname');

        expect(result, false);
        verify(mockDataSource.isNicknameAvailable('takenNickname')).called(1);
      });
    });

    group('isLoggedIn', () {
      test('should return true when session exists', () {
        when(mockDataSource.currentSession).thenReturn(
          supabase.Session(
            accessToken: 'test_token',
            tokenType: 'bearer',
            user: supabase.User(
              id: 'test_user_id',
              appMetadata: {},
              userMetadata: {},
              aud: 'authenticated',
              createdAt: DateTime.now().toIso8601String(),
            ),
          ),
        );

        final result = repository.isLoggedIn;

        expect(result, true);
      });

      test('should return false when no session', () {
        when(mockDataSource.currentSession).thenReturn(null);

        final result = repository.isLoggedIn;

        expect(result, false);
      });
    });

    group('currentUser', () {
      test('should return null initially', () {
        final result = repository.currentUser;

        expect(result, isNull);
      });
    });

    group('signOut', () {
      test('should delegate to datasource and clear cached profile', () async {
        when(mockDataSource.signOut()).thenAnswer((_) async {});

        await repository.signOut();

        verify(mockDataSource.signOut()).called(1);
        expect(repository.currentUser, isNull);
      });
    });

    group('getProfile', () {
      test('should return null when profile does not exist', () async {
        when(mockDataSource.getProfile('unknown_id'))
            .thenAnswer((_) async => null);

        final result = await repository.getProfile('unknown_id');

        expect(result, isNull);
      });

      test('should return profile and cache it', () async {
        final profileModel = UserProfileModel(
          id: 'test_user_id',
          email: 'test@example.com',
          nickname: 'TestRunner',
          provider: 'google',
          createdAt: DateTime.now(),
        );

        when(mockDataSource.getProfile('test_user_id'))
            .thenAnswer((_) async => profileModel);

        final result = await repository.getProfile('test_user_id');

        expect(result, isNotNull);
        expect(result!.id, 'test_user_id');
        expect(result.email, 'test@example.com');
        expect(result.nickname, 'TestRunner');
        expect(repository.currentUser, isNotNull);
      });
    });

    group('updateProfile', () {
      test('should delegate to datasource and return updated profile',
          () async {
        final profile = UserProfile(
          id: 'test_user_id',
          email: 'test@example.com',
          nickname: 'UpdatedRunner',
          provider: AuthProvider.google,
          createdAt: DateTime.now(),
          weightKg: 70.0,
          goal: RunningGoal.marathon,
        );

        final updatedModel = UserProfileModel(
          id: 'test_user_id',
          email: 'test@example.com',
          nickname: 'UpdatedRunner',
          provider: 'google',
          createdAt: profile.createdAt,
          weightKg: 70.0,
          goal: 'marathon',
        );

        when(mockDataSource.upsertProfile(any))
            .thenAnswer((_) async => updatedModel);

        final result = await repository.updateProfile(profile);

        expect(result.nickname, 'UpdatedRunner');
        expect(result.weightKg, 70.0);
        expect(result.goal, RunningGoal.marathon);
        verify(mockDataSource.upsertProfile(any)).called(1);
      });
    });

    group('requestAccountDeletion', () {
      test('should throw exception when user not logged in', () async {
        when(mockDataSource.currentUser).thenReturn(null);

        expect(
          () => repository.requestAccountDeletion(),
          throwsException,
        );
      });

      test('should delegate to datasource when user is logged in', () async {
        final testUser = supabase.User(
          id: 'test_user_id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );

        when(mockDataSource.currentUser).thenReturn(testUser);
        when(mockDataSource.requestAccountDeletion('test_user_id'))
            .thenAnswer((_) async {});

        await repository.requestAccountDeletion();

        verify(mockDataSource.requestAccountDeletion('test_user_id')).called(1);
      });
    });

    group('cancelAccountDeletion', () {
      test('should throw exception when user not logged in', () async {
        when(mockDataSource.currentUser).thenReturn(null);

        expect(
          () => repository.cancelAccountDeletion(),
          throwsException,
        );
      });

      test('should delegate to datasource when user is logged in', () async {
        final testUser = supabase.User(
          id: 'test_user_id',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        );

        when(mockDataSource.currentUser).thenReturn(testUser);
        when(mockDataSource.cancelAccountDeletion('test_user_id'))
            .thenAnswer((_) async {});

        await repository.cancelAccountDeletion();

        verify(mockDataSource.cancelAccountDeletion('test_user_id')).called(1);
      });
    });
  });
}
