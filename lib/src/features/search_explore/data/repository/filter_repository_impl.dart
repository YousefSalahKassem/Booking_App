import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/filter_data_source.dart';
import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/filter_repository.dart';
import 'package:dartz/dartz.dart';

class FilterRepositoryImpl implements FilterRepository {
  final FilterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FilterRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<HotelsEntity>>> getFilters(FilterModel filterEntity) async {
    try {
      final response = await remoteDataSource.getFilters(filterEntity);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
