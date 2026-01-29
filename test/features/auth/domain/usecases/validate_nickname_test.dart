import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/auth/domain/repositories/auth_repository.dart';
import 'package:running_mate/features/auth/domain/usecases/validate_nickname.dart';

import 'validate_nickname_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late ValidateNickname useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = ValidateNickname(mockRepository);
  });

  group('ValidateNickname', () {
    test('should return error for empty nickname', () async {
      final result = await useCase('');
      expect(result, NicknameValidationResult.empty);
    });

    test('should return error for too short nickname (< 2 chars)', () async {
      final result = await useCase('A');
      expect(result, NicknameValidationResult.tooShort);
    });

    test('should return error for too long nickname (> 10 chars)', () async {
      final result = await useCase('러너닉네임너무길어요요');
      expect(result, NicknameValidationResult.tooLong);
    });

    test('should return error for invalid characters', () async {
      final result = await useCase('러너@킴');
      expect(result, NicknameValidationResult.invalidCharacters);
    });

    test('should return duplicate when nickname taken', () async {
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => false);

      final result = await useCase('러너킴');
      expect(result, NicknameValidationResult.duplicate);
    });

    test('should return valid for available nickname', () async {
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => true);

      final result = await useCase('러너킴');
      expect(result, NicknameValidationResult.valid);
    });

    test('should accept Korean characters', () async {
      when(mockRepository.isNicknameAvailable('한글닉네임'))
          .thenAnswer((_) async => true);

      final result = await useCase('한글닉네임');
      expect(result, NicknameValidationResult.valid);
    });

    test('should accept English characters', () async {
      when(mockRepository.isNicknameAvailable('Runner'))
          .thenAnswer((_) async => true);

      final result = await useCase('Runner');
      expect(result, NicknameValidationResult.valid);
    });

    test('should accept numbers', () async {
      when(mockRepository.isNicknameAvailable('러너123'))
          .thenAnswer((_) async => true);

      final result = await useCase('러너123');
      expect(result, NicknameValidationResult.valid);
    });
  });
}
