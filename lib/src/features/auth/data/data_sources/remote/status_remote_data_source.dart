import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';

abstract class StatusRemoteDataSource {
  Future<StatusModel> getLoginStatus();
}

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {
  final ApiConsumer apiConsumer;

  StatusRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<StatusModel> getLoginStatus() async {
    final response = await apiConsumer.post(Endpoints.login);
    return StatusModel.fromJson(response);
  }
}
