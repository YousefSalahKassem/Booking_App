import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/local/booking_user_local_data_source.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/login_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/login_repository.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;
  final BookingUserLocalDataSource bookingUserLocalDataSource;

  LoginRepositoryImpl({
    required this.networkInfo,
    required this.loginRemoteDataSource,
    required this.bookingUserLocalDataSource,
  });

  @override
  Future<Either<Failure, BookingUser>> logIn(LoginModel loginModel) async {
    try {
      final response = await loginRemoteDataSource.logIn(loginModel);
      debugPrint('$runtimeType');
      debugPrint('response = $response');
      bookingUserLocalDataSource.cacheUserData(response);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
