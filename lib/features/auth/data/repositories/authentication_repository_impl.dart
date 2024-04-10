import 'package:test_app/features/auth/data/datasources/authentication_remote_datasource.dart';
import 'package:test_app/features/auth/domain/entities/user_entity.dart';
import 'package:test_app/features/auth/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  AuthenticationRepositoryImpl(this.remoteDataSource);
  @override
  Future<UserEntity> login(String username, String password) async {
    final userModel = await remoteDataSource.login(username, password);
    return userModel;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
