import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/network/network_info.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/remote/register_remote_data_source.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepositoryImpl({
    required this.networkInfo,
    required this.registerRemoteDataSource,
  });

  @override
  Future<Either<Failure, StatusEntity>> register(RegisterModel registerModel) async {
    try {
      final response = await registerRemoteDataSource.register(registerModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
