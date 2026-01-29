// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'a6ba8999daa4316be1049baac144c43bed696e1c';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSource>.internal(
      authRemoteDataSource,
      name: r'authRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'5ea3fe363d8516b372a67524a2da1bfea56705df';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$currentUserHash() => r'f3819d0a173411f041bf4aa1d47cfa1e0dec95d0';

/// See also [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider =
    AutoDisposeNotifierProvider<CurrentUser, UserProfile?>.internal(
      CurrentUser.new,
      name: r'currentUserProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentUser = AutoDisposeNotifier<UserProfile?>;
String _$authStateNotifierHash() => r'897ea9d65bd8f7a22580506df0d2e53192dc925c';

/// See also [AuthStateNotifier].
@ProviderFor(AuthStateNotifier)
final authStateNotifierProvider =
    AutoDisposeNotifierProvider<AuthStateNotifier, app.AuthState>.internal(
      AuthStateNotifier.new,
      name: r'authStateNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authStateNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthStateNotifier = AutoDisposeNotifier<app.AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
