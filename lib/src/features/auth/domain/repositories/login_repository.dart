import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, StatusEntity>> logIn(LoginModel loginModel);
}
