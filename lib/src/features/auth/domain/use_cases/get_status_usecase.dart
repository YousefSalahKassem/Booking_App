import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/status_repository.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:dartz/dartz.dart';

class GetStatusUseCase implements UseCase<BookingUserModel, NoParams> {
  final StatusRepository statusRepository;

  GetStatusUseCase({required this.statusRepository});

  @override
  Future<Either<Failure, BookingUserModel>> call(params) {
    return statusRepository.getStatus();
  }
}
