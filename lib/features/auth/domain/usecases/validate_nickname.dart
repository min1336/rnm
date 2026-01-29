import '../repositories/auth_repository.dart';

enum NicknameValidationResult {
  valid,
  empty,
  tooShort,
  tooLong,
  invalidCharacters,
  duplicate,
}

class ValidateNickname {
  final AuthRepository _repository;

  // 한글, 영문, 숫자만 허용
  static final _validPattern = RegExp(r'^[가-힣a-zA-Z0-9]+$');
  static const _minLength = 2;
  static const _maxLength = 10;

  ValidateNickname(this._repository);

  Future<NicknameValidationResult> call(String nickname) async {
    // 빈 문자열 체크
    if (nickname.isEmpty) {
      return NicknameValidationResult.empty;
    }

    // 길이 체크
    if (nickname.length < _minLength) {
      return NicknameValidationResult.tooShort;
    }
    if (nickname.length > _maxLength) {
      return NicknameValidationResult.tooLong;
    }

    // 문자 패턴 체크
    if (!_validPattern.hasMatch(nickname)) {
      return NicknameValidationResult.invalidCharacters;
    }

    // 중복 체크
    final isAvailable = await _repository.isNicknameAvailable(nickname);
    if (!isAvailable) {
      return NicknameValidationResult.duplicate;
    }

    return NicknameValidationResult.valid;
  }
}
