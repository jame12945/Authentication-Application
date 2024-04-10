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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text('Username: ${userEntity.username}'),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text('Token: ${userEntity.token}'),
          // ),
          Expanded(
            child: data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Text(item);
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
