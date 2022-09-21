import 'package:bookingapp/src/features/booking/data/model/Booking_Hotel_image.dart';
import 'package:bookingapp/src/features/booking/data/model/hotel_Booking_Facilities.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_hotels.dart';

class BookingHotelModel extends BookingHotelsEntity {
  BookingHotelModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.images,
    required super.facilities,
  });

  factory BookingHotelModel.fromJson(Map<String, dynamic> json) {
    return BookingHotelModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      images: List<BookingHotelImages>.from(
          json["hotel_images"].map((e) => BookingHotelImages.fromJson(e))),
      facilities: List<BookingFacilitiesModel>.from(json["facilities"]
          .map((e) => BookingFacilitiesModel.fromJson(e))),
    );
  }
}
