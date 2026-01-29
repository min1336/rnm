import '../entities/auth_provider.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class SignInWithSocial {
  final AuthRepository _repository;

  SignInWithSocial(this._repository);

  Future<UserProfile> call(AuthProvider provider) {
    return _repository.signInWithProvider(provider);
  }
}
