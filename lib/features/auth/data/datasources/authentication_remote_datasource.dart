import 'package:http/http.dart' as http;
import 'package:test_app/core/api/app_api.dart';
import 'dart:convert';

import 'package:test_app/features/auth/data/models/user_model.dart';

class AuthenticationRemoteDataSource {
  final String loginUrl = AppApi.baseUrl;

  Future<UserModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$loginUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      try {
        return UserModel.fromJson(responseData);
      } on Exception catch (e) {
        print('Error: $e');
        throw Exception('Failed to parse login response');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {}
}
