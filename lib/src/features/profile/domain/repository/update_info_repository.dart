import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/update_info_model.dart';

abstract class UpdateInfoRepository {

  Future<Either<Failure, BookingUser>> updateInfo(UpdateInfoModel params);
}