// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamificationDataSourceHash() =>
    r'2d95fb40ec3265fecd3dc8dddb2a9ca9e0462994';

/// See also [gamificationDataSource].
@ProviderFor(gamificationDataSource)
final gamificationDataSourceProvider =
    AutoDisposeProvider<GamificationRemoteDataSource>.internal(
      gamificationDataSource,
      name: r'gamificationDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gamificationDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GamificationDataSourceRef =
    AutoDisposeProviderRef<GamificationRemoteDataSource>;
String _$gamificationRepositoryHash() =>
    r'4292afa16f388ffc5d87a781978ce4d6f8d24e6b';

/// See also [gamificationRepository].
@ProviderFor(gamificationRepository)
final gamificationRepositoryProvider =
    AutoDisposeProvider<GamificationRepository>.internal(
      gamificationRepository,
      name: r'gamificationRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gamificationRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GamificationRepositoryRef =
    AutoDisposeProviderRef<GamificationRepository>;
String _$processRunCompletionHash() =>
    r'434571e3937d8ca7db62c5127671d3efd24ded80';

/// See also [processRunCompletion].
@ProviderFor(processRunCompletion)
final processRunCompletionProvider =
    AutoDisposeProvider<ProcessRunCompletion>.internal(
      processRunCompletion,
      name: r'processRunCompletionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$processRunCompletionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProcessRunCompletionRef = AutoDisposeProviderRef<ProcessRunCompletion>;
String _$userLevelHash() => r'aff3afbf9a8041872619e2f7837bbe315ccdb4bd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userLevel].
@ProviderFor(userLevel)
const userLevelProvider = UserLevelFamily();

/// See also [userLevel].
class UserLevelFamily extends Family<AsyncValue<UserLevel>> {
  /// See also [userLevel].
  const UserLevelFamily();

  /// See also [userLevel].
  UserLevelProvider call(String userId) {
    return UserLevelProvider(userId);
  }

  @override
  UserLevelProvider getProviderOverride(covariant UserLevelProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userLevelProvider';
}

/// See also [userLevel].
class UserLevelProvider extends AutoDisposeFutureProvider<UserLevel> {
  /// See also [userLevel].
  UserLevelProvider(String userId)
    : this._internal(
        (ref) => userLevel(ref as UserLevelRef, userId),
        from: userLevelProvider,
        name: r'userLevelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userLevelHash,
        dependencies: UserLevelFamily._dependencies,
        allTransitiveDependencies: UserLevelFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserLevelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<UserLevel> Function(UserLevelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserLevelProvider._internal(
        (ref) => create(ref as UserLevelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserLevel> createElement() {
    return _UserLevelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserLevelProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserLevelRef on AutoDisposeFutureProviderRef<UserLevel> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserLevelProviderElement
    extends AutoDisposeFutureProviderElement<UserLevel>
    with UserLevelRef {
  _UserLevelProviderElement(super.provider);

  @override
  String get userId => (origin as UserLevelProvider).userId;
}

String _$userAchievementsHash() => r'd2dac8fe48f56b0b5faa38f35f47d7448f8ed4f6';

/// See also [userAchievements].
@ProviderFor(userAchievements)
const userAchievementsProvider = UserAchievementsFamily();

/// See also [userAchievements].
class UserAchievementsFamily extends Family<AsyncValue<List<UserAchievement>>> {
  /// See also [userAchievements].
  const UserAchievementsFamily();

  /// See also [userAchievements].
  UserAchievementsProvider call(String userId) {
    return UserAchievementsProvider(userId);
  }

  @override
  UserAchievementsProvider getProviderOverride(
    covariant UserAchievementsProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userAchievementsProvider';
}

/// See also [userAchievements].
class UserAchievementsProvider
    extends AutoDisposeFutureProvider<List<UserAchievement>> {
  /// See also [userAchievements].
  UserAchievementsProvider(String userId)
    : this._internal(
        (ref) => userAchievements(ref as UserAchievementsRef, userId),
        from: userAchievementsProvider,
        name: r'userAchievementsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userAchievementsHash,
        dependencies: UserAchievementsFamily._dependencies,
        allTransitiveDependencies:
            UserAchievementsFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserAchievementsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<UserAchievement>> Function(UserAchievementsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserAchievementsProvider._internal(
        (ref) => create(ref as UserAchievementsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserAchievement>> createElement() {
    return _UserAchievementsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserAchievementsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserAchievementsRef
    on AutoDisposeFutureProviderRef<List<UserAchievement>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserAchievementsProviderElement
    extends AutoDisposeFutureProviderElement<List<UserAchievement>>
    with UserAchievementsRef {
  _UserAchievementsProviderElement(super.provider);

  @override
  String get userId => (origin as UserAchievementsProvider).userId;
}

String _$allAchievementsHash() => r'51ce85661220732c79607903d519c43e45b706a6';

/// See also [allAchievements].
@ProviderFor(allAchievements)
final allAchievementsProvider =
    AutoDisposeFutureProvider<List<Achievement>>.internal(
      allAchievements,
      name: r'allAchievementsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allAchievementsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllAchievementsRef = AutoDisposeFutureProviderRef<List<Achievement>>;
String _$activeChallengesHash() => r'8c785a3613dab2e18a67b1b4b652b33a070f7022';

/// See also [activeChallenges].
@ProviderFor(activeChallenges)
final activeChallengesProvider =
    AutoDisposeFutureProvider<List<Challenge>>.internal(
      activeChallenges,
      name: r'activeChallengesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeChallengesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveChallengesRef = AutoDisposeFutureProviderRef<List<Challenge>>;
String _$userChallengesHash() => r'3416a1a964eca584d43f2626137737b62ed943bc';

/// See also [userChallenges].
@ProviderFor(userChallenges)
const userChallengesProvider = UserChallengesFamily();

/// See also [userChallenges].
class UserChallengesFamily extends Family<AsyncValue<List<UserChallenge>>> {
  /// See also [userChallenges].
  const UserChallengesFamily();

  /// See also [userChallenges].
  UserChallengesProvider call(String userId) {
    return UserChallengesProvider(userId);
  }

  @override
  UserChallengesProvider getProviderOverride(
    covariant UserChallengesProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userChallengesProvider';
}

/// See also [userChallenges].
class UserChallengesProvider
    extends AutoDisposeFutureProvider<List<UserChallenge>> {
  /// See also [userChallenges].
  UserChallengesProvider(String userId)
    : this._internal(
        (ref) => userChallenges(ref as UserChallengesRef, userId),
        from: userChallengesProvider,
        name: r'userChallengesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userChallengesHash,
        dependencies: UserChallengesFamily._dependencies,
        allTransitiveDependencies:
            UserChallengesFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserChallengesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<UserChallenge>> Function(UserChallengesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserChallengesProvider._internal(
        (ref) => create(ref as UserChallengesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserChallenge>> createElement() {
    return _UserChallengesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserChallengesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserChallengesRef on AutoDisposeFutureProviderRef<List<UserChallenge>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserChallengesProviderElement
    extends AutoDisposeFutureProviderElement<List<UserChallenge>>
    with UserChallengesRef {
  _UserChallengesProviderElement(super.provider);

  @override
  String get userId => (origin as UserChallengesProvider).userId;
}

String _$weeklyLeaderboardHash() => r'a852cd90af5361edc3690fd9256e6db6361e122d';

/// See also [weeklyLeaderboard].
@ProviderFor(weeklyLeaderboard)
final weeklyLeaderboardProvider =
    AutoDisposeFutureProvider<List<LeaderboardEntry>>.internal(
      weeklyLeaderboard,
      name: r'weeklyLeaderboardProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weeklyLeaderboardHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeeklyLeaderboardRef =
    AutoDisposeFutureProviderRef<List<LeaderboardEntry>>;
String _$monthlyLeaderboardHash() =>
    r'd474bfc92c3ebaef80452285ad5d1c93a022280e';

/// See also [monthlyLeaderboard].
@ProviderFor(monthlyLeaderboard)
final monthlyLeaderboardProvider =
    AutoDisposeFutureProvider<List<LeaderboardEntry>>.internal(
      monthlyLeaderboard,
      name: r'monthlyLeaderboardProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$monthlyLeaderboardHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MonthlyLeaderboardRef =
    AutoDisposeFutureProviderRef<List<LeaderboardEntry>>;
String _$userWeeklyRankHash() => r'977e978640c63c47f1c75789a2feb31200b91fb8';

/// See also [userWeeklyRank].
@ProviderFor(userWeeklyRank)
const userWeeklyRankProvider = UserWeeklyRankFamily();

/// See also [userWeeklyRank].
class UserWeeklyRankFamily extends Family<AsyncValue<LeaderboardEntry?>> {
  /// See also [userWeeklyRank].
  const UserWeeklyRankFamily();

  /// See also [userWeeklyRank].
  UserWeeklyRankProvider call(String userId) {
    return UserWeeklyRankProvider(userId);
  }

  @override
  UserWeeklyRankProvider getProviderOverride(
    covariant UserWeeklyRankProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userWeeklyRankProvider';
}

/// See also [userWeeklyRank].
class UserWeeklyRankProvider
    extends AutoDisposeFutureProvider<LeaderboardEntry?> {
  /// See also [userWeeklyRank].
  UserWeeklyRankProvider(String userId)
    : this._internal(
        (ref) => userWeeklyRank(ref as UserWeeklyRankRef, userId),
        from: userWeeklyRankProvider,
        name: r'userWeeklyRankProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userWeeklyRankHash,
        dependencies: UserWeeklyRankFamily._dependencies,
        allTransitiveDependencies:
            UserWeeklyRankFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserWeeklyRankProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<LeaderboardEntry?> Function(UserWeeklyRankRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserWeeklyRankProvider._internal(
        (ref) => create(ref as UserWeeklyRankRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeaderboardEntry?> createElement() {
    return _UserWeeklyRankProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserWeeklyRankProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserWeeklyRankRef on AutoDisposeFutureProviderRef<LeaderboardEntry?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserWeeklyRankProviderElement
    extends AutoDisposeFutureProviderElement<LeaderboardEntry?>
    with UserWeeklyRankRef {
  _UserWeeklyRankProviderElement(super.provider);

  @override
  String get userId => (origin as UserWeeklyRankProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
