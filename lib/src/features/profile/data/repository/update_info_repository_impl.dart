import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:bookingapp/src/features/profile/data/datasource/update_info_data_source.dart';
import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:bookingapp/src/features/profile/domain/repository/update_info_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateInfoRepositoryImpl implements UpdateInfoRepository {
  final UpdateInfoDataSource remoteDataSource;

  UpdateInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BookingUserModel>> updateInfo(UpdateInfoModel updateInfoModel) async {
    try {
      final user = await remoteDataSource.updateInfo(updateInfoModel);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
