import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/local/booking_user_local_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/register_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/register_repository.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource registerRemoteDataSource;
  final BookingUserLocalDataSource bookingUserLocalDataSource;

  RegisterRepositoryImpl({
    required this.networkInfo,
    required this.registerRemoteDataSource,
    required this.bookingUserLocalDataSource,
  });

  @override
  Future<Either<Failure, BookingUser>> register(RegisterModel registerModel) async {
    try {
      final response = await registerRemoteDataSource.register(registerModel);
      debugPrint('$runtimeType');
      debugPrint('response = $response');
      bookingUserLocalDataSource.cacheApiToken(response);
      bookingUserLocalDataSource.cacheUserData(response);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
