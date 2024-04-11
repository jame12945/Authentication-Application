import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/core/theme/app_pallete.dart';
import 'package:test_app/features/auth/domain/entities/user_entity.dart';
import 'package:test_app/features/auth/presentation/views/data_view.dart';
import 'package:test_app/main.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Using Hook For Management value of username and password
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
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
              const SizedBox(height: 20),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login_icon.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 4),
                  Text('Sign In',
                      style:
                          TextStyle(fontSize: 16, color: AppPallete.grayColor)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 40),
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
