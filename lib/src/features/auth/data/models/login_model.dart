import 'package:bookingapp/src/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
