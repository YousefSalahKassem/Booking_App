import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';

abstract class AuthRemoteDataSource {
  Future<StatusModel> login();
  // TODO: register
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<StatusModel> login() async {
    final response = await apiConsumer.post(Endpoints.login);
    return response;
  }
}
