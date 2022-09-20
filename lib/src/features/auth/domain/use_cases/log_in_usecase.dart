import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LogInUseCase implements UseCase<StatusEntity, LoginModel> {
  final LoginRepository loginRepository;

  LogInUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, StatusEntity>> call(params) {
    return loginRepository.logIn(params);
  }
}
