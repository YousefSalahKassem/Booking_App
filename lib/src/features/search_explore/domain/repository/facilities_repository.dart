import 'package:bookingapp/src/features/search_explore/domain/entities/facilities_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class FacilitiesRepository {
  Future<Either<Failure, List<FacilitiesEntity>>> getFacilities();
}