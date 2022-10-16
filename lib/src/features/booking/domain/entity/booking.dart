import 'package:bookingapp/src/features/booking/data/model/booking_hotel_model.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';

class Booking {
  final int id;
  final String userId;
  final String hotelId;
  final String type;
  final String createdAt;
  final String updatedAt;
  final BookingUserModel user;
  final BookingHotelModel hotel;

  const Booking({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.hotel,
  });
}
