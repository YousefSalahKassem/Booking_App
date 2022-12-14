import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';

abstract class StatusRemoteDataSource {
  Future<bool> getLoginStatus();
}

class StatusRemoteDataSourceImpl implements StatusRemoteDataSource {
  final ApiConsumer apiConsumer;

  StatusRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<bool> getLoginStatus() async {
    final response = await apiConsumer.post(Endpoints.login);
    return BookingUserModel.fromJson(response).apiToken != null;
  }
}
