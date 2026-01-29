import '../entities/auth_state.dart';
import '../repositories/auth_repository.dart';

class CheckAuthState {
  final AuthRepository _repository;

  CheckAuthState(this._repository);

  Future<AuthState> call() {
    return _repository.checkAuthState();
  }
}
