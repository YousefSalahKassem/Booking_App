import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';

abstract class LoginRemoteDataSource {
  Future<BookingUserModel> logIn(LoginModel loginModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiConsumer apiConsumer;

  LoginRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<BookingUserModel> logIn(LoginModel loginModel) async {
    final response = await apiConsumer.post(Endpoints.login, body: loginModel.toJson());
    return BookingUserModel.fromJson(response['data']);
  }
}
