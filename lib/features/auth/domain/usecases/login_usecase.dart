import 'package:test_app/features/auth/domain/entities/user_entity.dart';
import 'package:test_app/features/auth/domain/repositories/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);
  Future<UserEntity> call(String username, String password) {
    return repository.login(
      username,
      password,
    );
  }
}
