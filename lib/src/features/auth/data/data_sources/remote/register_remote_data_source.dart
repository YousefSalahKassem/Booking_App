import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';

abstract class RegisterRemoteDataSource {
  Future<StatusModel> register(RegisterModel registerModel);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiConsumer apiConsumer;

  RegisterRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<StatusModel> register(RegisterModel registerModel) async {
    final response = await apiConsumer.post(Endpoints.register, body: registerModel.toJson());
    return StatusModel.fromJson(response);
  }
}
