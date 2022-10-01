import 'package:bookingapp/src/features/booking/data/model/booking_hotel_model.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.userId,
    required super.hotelId,
    required super.type,
    required super.createdAt,
    required super.updatedAt,
    required super.hotel,
    required super.user,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"],
      userId: json["user_id"],
      hotelId: json["hotel_id"],
      type: json["type"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      hotel: BookingHotelModel.fromJson(json["hotel"]),
      user: BookingUserModel.fromJson(json["user"]),
    );
  }
}
