import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/logout_usecase.dart';

class AuthenticationNotifier extends StateNotifier<String?> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthenticationNotifier(this._loginUseCase, this._logoutUseCase) : super(null);

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final result = await _loginUseCase(username, password);
    state = result.token;
  }

  Future<void> logout() async {
    await _logoutUseCase();
    state = null;
  }
}
