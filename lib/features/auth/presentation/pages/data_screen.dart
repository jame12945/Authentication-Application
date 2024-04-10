import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/features/auth/domain/entities/user_entity.dart';
import 'package:test_app/features/auth/presentation/pages/login_screen.dart';
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
        title: const Text('Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authenticationProvider.notifier).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/homePic.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Center(
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
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
