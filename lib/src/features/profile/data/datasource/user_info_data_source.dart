import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';

abstract class UserInfoDataSource {
  Future<BookingUserModel> getUserInfo();
}

class UserInfoDataSourceImpl implements UserInfoDataSource {
  final ApiConsumer consumer;

  UserInfoDataSourceImpl({required this.consumer});

  @override
  Future<BookingUserModel> getUserInfo() async {
    final response = await consumer.get(Endpoints.userInfo);
    return BookingUserModel.fromJson(response['data']);
  }
}
