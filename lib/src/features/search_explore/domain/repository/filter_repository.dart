import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FilterRepository {
  Future<Either<Failure, List<HotelsEntity>>> getFilters(FilterModel filterModel);
}
