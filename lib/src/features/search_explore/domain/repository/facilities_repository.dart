import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/facilities_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FacilitiesRepository {
  Future<Either<Failure, List<FacilitiesEntity>>> getFacilities();
}
