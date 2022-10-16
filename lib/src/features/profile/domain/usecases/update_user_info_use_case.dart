import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:bookingapp/src/features/profile/domain/repository/update_info_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserInfoUseCase extends UseCase<BookingUser, UpdateInfoModel> {
  final UpdateInfoRepository repository;

  UpdateUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, BookingUser>> call(params) async {
    return await repository.updateInfo(params);
  }
}
