import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/status_repository.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';

class GetLoginStatusUseCase implements UseCase<bool, NoParams> {
  final StatusRepository loginStatusRepository;

  GetLoginStatusUseCase({required this.loginStatusRepository});

  @override
  Future<Either<Failure, bool>> call(params) {
    return loginStatusRepository.getLoginStatus();
  }
}
