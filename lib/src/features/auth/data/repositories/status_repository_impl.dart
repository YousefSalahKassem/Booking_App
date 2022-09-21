import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/local/status_local_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/status_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/status_repository.dart';
import 'package:dartz/dartz.dart';

class StatusRepositoryImpl implements StatusRepository {
  final NetworkInfo networkInfo;
  final StatusRemoteDataSource statusRemoteDataSource;
  final StatusLocalDataSource statusLocalDataSource;

  StatusRepositoryImpl({
    required this.networkInfo,
    required this.statusRemoteDataSource,
    required this.statusLocalDataSource,
  });

  @override
  Future<Either<Failure, StatusEntity>> getLoginStatus() async {
    try {
      final response = await statusRemoteDataSource.getLoginStatus();
      statusLocalDataSource.cacheStatus(response);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
