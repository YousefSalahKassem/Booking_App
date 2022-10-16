import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateInfoRepository {
  Future<Either<Failure, BookingUser>> updateInfo(UpdateInfoModel params);
}
