import 'package:bookingapp/src/features/booking/domain/entity/booking_facilities.dart';

class BookingFacilitiesModel extends BookingFacilitiesEntity {
  BookingFacilitiesModel({
    required final String name,
    required final String image,
    required final int id,
  }) : super(name: name, image: image, id: id);

  factory BookingFacilitiesModel.fromJson(Map<String, dynamic> json) {
    return BookingFacilitiesModel(
      name: json["name"],
      image: json["image"],
      id: json["id"],
    );
  }
}

class HotelFacilityModel {
  final String id;

  HotelFacilityModel({
    required this.id,
  });

  factory HotelFacilityModel.fromJson(Map<String, dynamic> json) {
    return HotelFacilityModel(
      id: json["id"],
    );
  }
}
