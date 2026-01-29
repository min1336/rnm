import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/auth/domain/repositories/auth_repository.dart';
import 'package:running_mate/features/auth/domain/usecases/request_account_deletion.dart';

import 'request_account_deletion_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late RequestAccountDeletion useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = RequestAccountDeletion(mockRepository);
  });

  group('RequestAccountDeletion', () {
    test('should call repository requestAccountDeletion and signOut', () async {
      when(mockRepository.requestAccountDeletion())
          .thenAnswer((_) async {});
      when(mockRepository.signOut())
          .thenAnswer((_) async {});

      await useCase();

      verify(mockRepository.requestAccountDeletion()).called(1);
      verify(mockRepository.signOut()).called(1);
    });
  });
}
