import 'package:bookingapp/src/features/booking/data/model/booking_hotel_image.dart';
import 'package:bookingapp/src/features/booking/data/model/hotel_booking_facilities.dart';

class BookingHotelsEntity {
  final int id;
  final String name;
  final String description;
  final String price;
  final String address;
  final String latitude;
  final String longitude;
  final List<BookingHotelImages> images;
  final List<BookingFacilitiesModel> facilities;

  const BookingHotelsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.facilities,
  });
}
