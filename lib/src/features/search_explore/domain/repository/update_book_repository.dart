import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateBookingRepository {
  Future<Either<Failure, StatusEntity>> update(UpdateBookingModel updateBookingModel);
}
