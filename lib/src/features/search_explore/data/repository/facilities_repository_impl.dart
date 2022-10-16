import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/facilities_remote_data_source.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/facilities_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/facilities_repository.dart';
import 'package:dartz/dartz.dart';

class FacilitiesRepositoryImpl implements FacilitiesRepository {
  final NetworkInfo networkInfo;
  final FacilitiesRemoteDataSource remoteDataSource;

  FacilitiesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<FacilitiesEntity>>> getFacilities() async {
    try {
      final facilities = await remoteDataSource.getFacilities();
      return Right(facilities);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
