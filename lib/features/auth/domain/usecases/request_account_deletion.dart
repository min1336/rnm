import '../repositories/auth_repository.dart';

class RequestAccountDeletion {
  final AuthRepository _repository;

  RequestAccountDeletion(this._repository);

  Future<void> call() async {
    await _repository.requestAccountDeletion();
    await _repository.signOut();
  }
}
