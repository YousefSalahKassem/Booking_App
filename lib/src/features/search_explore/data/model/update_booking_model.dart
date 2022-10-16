import 'package:bookingapp/src/features/search_explore/domain/entities/create_booking_entity.dart';

class UpdateBookingModel extends CreateBookingEntity {
  UpdateBookingModel({required super.hotelId, required super.type});

  Map<String, dynamic> toJson() {
    return {
      'booking_id': hotelId,
      "type": type,
    };
  }
}
