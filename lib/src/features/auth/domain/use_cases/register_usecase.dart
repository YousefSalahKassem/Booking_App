import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/register_repository.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements UseCase<BookingUser, RegisterModel> {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  @override
  Future<Either<Failure, BookingUser>> call(params) {
    return registerRepository.register(params);
  }
}
