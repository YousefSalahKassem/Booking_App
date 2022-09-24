import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, BookingUser>> logIn(LoginModel loginModel);
}
