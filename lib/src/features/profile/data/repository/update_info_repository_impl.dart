import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../booking/data/model/booking_user_model.dart';
import '../../domain/repository/update_info_repository.dart';
import '../datasource/update_info_data_source.dart';

class UpdateInfoRepositoryImpl implements UpdateInfoRepository {
  final UpdateInfoDataSource remoteDataSource;

  UpdateInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BookingUserModel>> updateInfo(
      UpdateInfoModel updateInfoModel) async {
    try {
      final user = await remoteDataSource.updateInfo(updateInfoModel);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}