import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:bookingapp/src/features/profile/data/datasource/user_info_data_source.dart';
import 'package:bookingapp/src/features/profile/domain/repository/user_info_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class UserProfileRepositoryImpl implements UserInfoRepository {
  final UserInfoDataSource dataSource;

  UserProfileRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, BookingUser>> getUserInfo() async {
    try {
      final user = await dataSource.getUserInfo();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}