import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/local/status_local_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/status_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/status_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

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
  Future<Either<Failure, bool>> getLoginStatus() async {
    /**
     * isLoggedIn == false if apiToken == null
     *
     * if (isLoggedIn != false) // we have an apiToken
     *    try
     *      get isLoggedIn data from cache
     *    catch
     *      cache failure
     * else
     *    if (internet is connected)
     *       try
     *          get isLoggedIn data from api
     *       catch
     *          server failure
     */
    bool isLoggedIn = false;
    debugPrint('bool isLoggedIn = $isLoggedIn');
    try {
      isLoggedIn = await statusLocalDataSource.getLoginStatus();
      debugPrint('await statusLocalDataSource.getLoginStatus() = $isLoggedIn');
      return Right(isLoggedIn);
    } on CacheException {
      return Left(CacheFailure());
    } finally {
      debugPrint('isLoggedIn = $isLoggedIn');
      if (isLoggedIn == false) {
        debugPrint('await networkInfo.isConnected = ${await networkInfo.isConnected}');
        if (await networkInfo.isConnected) {
          try {
            isLoggedIn = await statusRemoteDataSource.getLoginStatus();
            debugPrint('statusRemoteDataSource.getLoginStatus() = $isLoggedIn');
            statusLocalDataSource.cacheStatus();
            return Right(isLoggedIn);
          } on ServerException {
            return Left(ServerFailure());
          }
        } else {
          throw const NoInternetConnectionException();
        }
      }
    }
  }
}