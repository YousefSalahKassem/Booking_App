import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/endpoints.dart';
import '../../../auth/data/models/status_model.dart';

abstract class UpdateBookingDataSource {
  Future<StatusModel> updateBooking(UpdateBookingModel bookingModel);
}

class UpdateBookingDataSourceImpl implements UpdateBookingDataSource {
  final ApiConsumer apiConsumer;

  UpdateBookingDataSourceImpl({required this.apiConsumer});

  @override
  Future<StatusModel> updateBooking(UpdateBookingModel bookingModel) async {
    final response = await apiConsumer.post(Endpoints.updateBooking, body: bookingModel.toJson());
    return StatusModel.fromJson(response);
  }
}
