import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HotelsRepository {
  Future<Either<Failure, List<HotelsEntity>>> getHotels();
}
