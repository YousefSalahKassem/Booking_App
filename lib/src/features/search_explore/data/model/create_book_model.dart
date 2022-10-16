import 'package:bookingapp/src/features/search_explore/domain/entities/create_booking_entity.dart';

class CreateBookingModel extends CreateBookingEntity {
  CreateBookingModel({required super.hotelId, super.userId});

  Map<String, dynamic> toJson() {
    return {
      'hotel_id': hotelId,
    };
  }
}
