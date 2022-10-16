import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';
import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';

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
