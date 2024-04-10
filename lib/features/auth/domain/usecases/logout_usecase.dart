import 'package:test_app/features/auth/domain/repositories/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository repository;
  LogoutUseCase(this.repository);
  Future<void> call() {
    return repository.logout();
  }
}
