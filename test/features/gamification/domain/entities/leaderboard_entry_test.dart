import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/leaderboard_entry.dart';

void main() {
  group('LeaderboardEntry', () {
    test('should create entry with rank', () {
      final entry = LeaderboardEntry(
        userId: 'user-1',
        displayName: '김철수',
        totalDistance: 42.5,
        runCount: 8,
        rank: 1,
      );

      expect(entry.rank, 1);
      expect(entry.totalDistance, 42.5);
    });

    test('should create entry with optional avatar', () {
      final entry = LeaderboardEntry(
        userId: 'user-1',
        displayName: '김철수',
        avatarUrl: 'https://example.com/avatar.jpg',
        totalDistance: 42.5,
        runCount: 8,
        rank: 1,
      );

      expect(entry.avatarUrl, 'https://example.com/avatar.jpg');
    });

    test('should create entry without avatar', () {
      final entry = LeaderboardEntry(
        userId: 'user-1',
        displayName: '김철수',
        totalDistance: 42.5,
        runCount: 8,
        rank: 2,
      );

      expect(entry.avatarUrl, isNull);
    });

    test('should have correct user info', () {
      final entry = LeaderboardEntry(
        userId: 'user-123',
        displayName: '홍길동',
        totalDistance: 100.0,
        runCount: 15,
        rank: 3,
      );

      expect(entry.userId, 'user-123');
      expect(entry.displayName, '홍길동');
    });

    test('should have correct stats', () {
      final entry = LeaderboardEntry(
        userId: 'user-1',
        displayName: '김철수',
        totalDistance: 42.5,
        runCount: 8,
        rank: 1,
      );

      expect(entry.totalDistance, 42.5);
      expect(entry.runCount, 8);
    });
  });
}
