import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/theme/app_pallete.dart';
import 'package:test_app/features/auth/domain/entities/user_entity.dart';
import 'package:test_app/features/auth/presentation/views/login_view.dart';
import 'package:test_app/features/auth/presentation/widgets/data_input_widget.dart';
import 'package:test_app/main.dart';

class DataScreen extends ConsumerWidget {
  const DataScreen({Key? key, required this.userEntity}) : super(key: key);

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authToken = ref.watch(authenticationProvider);
    final dataNotifier = ref.watch(dataProvider.notifier);
    final data = ref.watch(dataProvider);

    if (authToken != null) {
      dataNotifier.fetchData(authToken);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Application'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              'Personal Profile',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppPallete.focusColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Container(
                              height: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: const AssetImage(
                                          'assets/profile_icon.png'),
                                      fit: BoxFit.contain)),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            DataInputItemWidget(
                              text: userEntity.username,
                              topic: 'Username',
                            ),
                            DataInputItemWidget(
                              text: userEntity.token,
                              topic: 'Token',
                            ),
                            DataInputItemWidget(
                              text: item,
                              topic: 'Response',
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                onPressed: () {
                                  ref
                                      .read(authenticationProvider.notifier)
                                      .logout();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Logout'))
                          ],
                        );
                      },
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
