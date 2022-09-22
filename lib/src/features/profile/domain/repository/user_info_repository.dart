import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../booking/domain/entity/booking_users.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, BookingUser>> getUserInfo();
}