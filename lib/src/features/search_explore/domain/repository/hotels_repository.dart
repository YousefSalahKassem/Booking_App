import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/hotels_entity.dart';

abstract class HotelsRepository {
  Future<Either<Failure, List<HotelsEntity>>> getHotels();
}