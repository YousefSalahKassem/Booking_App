import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';

abstract class RegisterRemoteDataSource {
  Future<BookingUserModel> register(RegisterModel registerModel);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiConsumer apiConsumer;

  RegisterRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<BookingUserModel> register(RegisterModel registerModel) async {
    final response = await apiConsumer.post(Endpoints.register, body: registerModel.toJson());
    return BookingUserModel.fromJson(response['data']);
  }
}
