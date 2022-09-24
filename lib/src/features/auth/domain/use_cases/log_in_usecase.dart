import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/login_repository.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';

class LogInUseCase implements UseCase<BookingUser, LoginModel> {
  final LoginRepository loginRepository;

  LogInUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, BookingUser>> call(params) {
    return loginRepository.logIn(params);
  }
}
