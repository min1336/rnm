import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/challenge.dart';

void main() {
  group('Challenge', () {
    test('should create weekly challenge', () {
      final challenge = Challenge(
        id: 'weekly-1',
        title: '이번 주 15km 달리기',
        type: ChallengeType.weekly,
        targetValue: 15,
        unit: 'km',
        xpReward: 100,
        startAt: DateTime(2026, 1, 27),
        endAt: DateTime(2026, 2, 2),
      );

      expect(challenge.type, ChallengeType.weekly);
      expect(challenge.targetValue, 15);
    });

    test('should create monthly challenge', () {
      final challenge = Challenge(
        id: 'monthly-1',
        title: '이번 달 50km 달리기',
        type: ChallengeType.monthly,
        targetValue: 50,
        unit: 'km',
        xpReward: 500,
        startAt: DateTime(2026, 1, 1),
        endAt: DateTime(2026, 1, 31),
      );

      expect(challenge.type, ChallengeType.monthly);
      expect(challenge.targetValue, 50);
    });

    test('should include optional description', () {
      final challenge = Challenge(
        id: 'special-1',
        title: '특별 챌린지',
        description: '특별한 이벤트 챌린지입니다',
        type: ChallengeType.special,
        targetValue: 100,
        unit: 'km',
        xpReward: 1000,
        startAt: DateTime(2026, 1, 1),
        endAt: DateTime(2026, 2, 1),
      );

      expect(challenge.description, '특별한 이벤트 챌린지입니다');
    });
  });

  group('UserChallenge', () {
    late Challenge challenge;

    setUp(() {
      challenge = Challenge(
        id: 'weekly-1',
        title: '이번 주 15km 달리기',
        type: ChallengeType.weekly,
        targetValue: 15,
        unit: 'km',
        xpReward: 100,
        startAt: DateTime(2026, 1, 27),
        endAt: DateTime(2026, 2, 2),
      );
    });

    test('should calculate progress percent correctly', () {
      final userChallenge = UserChallenge(
        userId: 'user-1',
        challengeId: 'weekly-1',
        challenge: challenge,
        currentProgress: 9,
        isCompleted: false,
        joinedAt: DateTime(2026, 1, 27),
      );

      expect(userChallenge.progressPercent, 0.6);
    });

    test('progress percent should be clamped to 1.0 maximum', () {
      final userChallenge = UserChallenge(
        userId: 'user-1',
        challengeId: 'weekly-1',
        challenge: challenge,
        currentProgress: 20, // More than target
        isCompleted: true,
        joinedAt: DateTime(2026, 1, 27),
      );

      expect(userChallenge.progressPercent, 1.0);
    });

    test('progress percent should be clamped to 0.0 minimum', () {
      final userChallenge = UserChallenge(
        userId: 'user-1',
        challengeId: 'weekly-1',
        challenge: challenge,
        currentProgress: 0,
        isCompleted: false,
        joinedAt: DateTime(2026, 1, 27),
      );

      expect(userChallenge.progressPercent, 0.0);
    });

    test('should detect expired challenge', () {
      final expiredChallenge = Challenge(
        id: 'expired-1',
        title: '만료된 챌린지',
        type: ChallengeType.weekly,
        targetValue: 15,
        unit: 'km',
        xpReward: 100,
        startAt: DateTime(2026, 1, 1),
        endAt: DateTime(2026, 1, 7), // Past date
      );

      final userChallenge = UserChallenge(
        userId: 'user-1',
        challengeId: 'expired-1',
        challenge: expiredChallenge,
        currentProgress: 5,
        isCompleted: false,
        joinedAt: DateTime(2026, 1, 1),
      );

      expect(userChallenge.isExpired, true);
    });

    test('should detect active challenge', () {
      final activeChallenge = Challenge(
        id: 'active-1',
        title: '진행 중 챌린지',
        type: ChallengeType.weekly,
        targetValue: 15,
        unit: 'km',
        xpReward: 100,
        startAt: DateTime(2026, 1, 27),
        endAt: DateTime(2030, 12, 31), // Future date
      );

      final userChallenge = UserChallenge(
        userId: 'user-1',
        challengeId: 'active-1',
        challenge: activeChallenge,
        currentProgress: 5,
        isCompleted: false,
        joinedAt: DateTime(2026, 1, 27),
      );

      expect(userChallenge.isExpired, false);
    });

    test('should track completed challenge with completedAt', () {
      final userChallenge = UserChallenge(
        userId: 'user-1',
        challengeId: 'weekly-1',
        challenge: challenge,
        currentProgress: 15,
        isCompleted: true,
        completedAt: DateTime(2026, 1, 30),
        joinedAt: DateTime(2026, 1, 27),
      );

      expect(userChallenge.isCompleted, true);
      expect(userChallenge.completedAt, isNotNull);
    });
  });
}
