import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, BookingUser>> getUserInfo();
}
