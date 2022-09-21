import 'package:bookingapp/src/features/search_explore/domain/entities/create_booking_entity.dart';

class CreateBookingModel extends CreateBookingEntity{
  CreateBookingModel({required super.hotelId});

  Map<String, dynamic> toJson() {
    return {
      'hotel_id': hotelId,
    };
  }
}

