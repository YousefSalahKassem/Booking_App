import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthUsecase implements UseCase<StatusEntity, NoParams> {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  @override
  Future<Either<Failure, StatusEntity>> call(params) {
    return authRepository.authenticate();
  }
}
