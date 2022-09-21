import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/login_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({
    required this.networkInfo,
    required this.loginRemoteDataSource,
  });

  @override
  Future<Either<Failure, StatusEntity>> logIn(LoginModel loginModel) async {
    try {
      final response = await loginRemoteDataSource.logIn(loginModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
