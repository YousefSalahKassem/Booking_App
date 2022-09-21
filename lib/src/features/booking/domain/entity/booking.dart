import 'package:bookingapp/src/features/booking/data/model/booking_hotel_model.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';

class Booking  {
  final int id;
  final int userId;
  final int hotelId;
  final String type;
  final String createdAt;
  final String updatedAt;
  final List<BookingUserModel> user;
  final List<BookingHotelModel> hotel;

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
