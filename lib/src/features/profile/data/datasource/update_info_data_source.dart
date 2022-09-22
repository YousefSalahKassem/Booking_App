import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';

import '../../../booking/data/model/booking_user_model.dart';
import '../model/update_info_model.dart';

abstract class UpdateInfoDataSource {
  Future<BookingUserModel> updateInfo(UpdateInfoModel params);
}

class UpdateInfoDataSourceImpl implements UpdateInfoDataSource {
  final ApiConsumer apiConsumer;

  UpdateInfoDataSourceImpl({required this.apiConsumer});
  @override
  Future<BookingUserModel> updateInfo(UpdateInfoModel params) async {
    final response = await apiConsumer.post(
      Endpoints.updateInfo,
      body: params.toJson(),
    );
    return BookingUserModel.fromJson(response['data']);
  }

}