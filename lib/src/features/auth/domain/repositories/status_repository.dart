import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:dartz/dartz.dart';

abstract class StatusRepository {
  Future<Either<Failure, BookingUserModel>> getStatus();
}
