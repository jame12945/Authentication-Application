import 'package:test_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String?;
    final username = token?.split(' ')[2];

    if (token == null || username == null) {
      throw Exception('Invalid JSON response');
    }

    return UserModel(
      username: username,
      token: token,
    );
  }
}
