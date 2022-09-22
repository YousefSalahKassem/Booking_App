import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../booking/domain/entity/booking_users.dart';
import '../../data/model/update_info_model.dart';
import '../repository/update_info_repository.dart';

class UpdateInfoUseCase extends UseCase<BookingUser, UpdateInfoModel> {
  final UpdateInfoRepository repository;

  UpdateInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, BookingUser>> call(params) async {
    return await repository.updateInfo(params);
  }
}