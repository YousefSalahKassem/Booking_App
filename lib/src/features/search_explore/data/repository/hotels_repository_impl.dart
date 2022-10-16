import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/search_explore/data/data_sources/hotels_remote_data_source.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/hotels_repository.dart';
import 'package:dartz/dartz.dart';

class HotelsRepositoryImpl implements HotelsRepository {
  final NetworkInfo networkInfo;
  final HotelsRemoteDataSource remoteDataSource;

  HotelsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HotelsEntity>>> getHotels() async {
    try {
      final hotels = await remoteDataSource.getHotels();
      return Right(hotels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
