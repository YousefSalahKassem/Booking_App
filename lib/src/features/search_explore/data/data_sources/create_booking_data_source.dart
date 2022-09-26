import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';
import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';

import '../../../../core/api/api_consumer.dart';

abstract class CreateBookingDataSource {
  Future<StatusModel> createBooking(CreateBookingModel bookingModel);
}

class CreateBookingDataSourceImpl implements CreateBookingDataSource {
  final ApiConsumer apiConsumer;

  CreateBookingDataSourceImpl({required this.apiConsumer});

  @override
  Future<StatusModel> createBooking(CreateBookingModel bookingModel) async {
    final response = await apiConsumer.post(Endpoints.booking, body: bookingModel.toJson());
    return StatusModel.fromJson(response);
  }
}
