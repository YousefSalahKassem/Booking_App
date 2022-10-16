import 'package:bookingapp/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class StatusRepository {
  Future<Either<Failure, bool>> getLoginStatus();
}
