import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/theme/theme.dart';
import 'package:test_app/features/auth/data/datasources/authentication_remote_datasource.dart';
import 'package:test_app/features/auth/data/datasources/data_remote_datasource.dart';
import 'package:test_app/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:test_app/features/auth/presentation/views/login_view.dart';
import 'package:test_app/features/auth/presentation/providers/authentication_provider.dart';
import 'package:test_app/features/auth/presentation/providers/data_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod App',
      theme: AppTheme.darkThemeMode,
      home: const LoginScreen(),
    );
  }
}

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, String?>((ref) {
  final authenticationRepository =
      AuthenticationRepositoryImpl(AuthenticationRemoteDataSource());
  final loginUseCase = LoginUseCase(authenticationRepository);
  final logoutUseCase = LogoutUseCase(authenticationRepository);

  return AuthenticationNotifier(loginUseCase, logoutUseCase);
});

final dataProvider = StateNotifierProvider<DataNotifier, List<dynamic>>((ref) {
  final dataRemoteDataSource = DataRemoteDataSource();
  return DataNotifier(dataRemoteDataSource);
});
