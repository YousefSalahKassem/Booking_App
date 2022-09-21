import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements UseCase<StatusEntity, RegisterModel> {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  @override
  Future<Either<Failure, StatusEntity>> call(params) {
    return registerRepository.register(params);
  }
}
