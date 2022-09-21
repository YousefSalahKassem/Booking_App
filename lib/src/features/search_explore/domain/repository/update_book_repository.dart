import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/status_entity.dart';

abstract class UpdateBookingRepository {
  Future<Either<Failure, StatusEntity>> update(UpdateBookingModel updateBookingModel);
}