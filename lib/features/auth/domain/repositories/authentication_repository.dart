import 'package:test_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<UserEntity> login(
    String username,
    String password,
  );
  Future<void> logout();
}
