import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/theme/app_pallete.dart';
import 'package:test_app/features/auth/domain/entities/user_entity.dart';
import 'package:test_app/features/auth/presentation/pages/data_screen.dart';
import 'package:test_app/main.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final authNotifier = ref.watch(authenticationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/login_icon.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 4),
                  Text('Sign In',
                      style:
                          TextStyle(fontSize: 16, color: AppPallete.grayColor)),
                  SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.succesColor,
                      foregroundColor: AppPallete.whiteColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () async {
                      await authNotifier.login(
                        username: usernameController.text,
                        password: passwordController.text,
                      );
                      final authToken = ref.read(authenticationProvider);
                      if (authToken != null) {
                        final userEntity = UserEntity(
                          username: usernameController.text,
                          token: authToken,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataScreen(
                              userEntity: userEntity,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
