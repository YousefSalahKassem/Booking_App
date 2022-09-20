import 'package:bookingapp/src/features/search_explore/data/model/hotel_images.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';

import 'facilities_model.dart';

class HotelsModel extends HotelsEntity{
  HotelsModel({
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

  factory HotelsModel.fromJson(Map<String, dynamic> json) {
    return HotelsModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      images: List<HotelImages>.from(json["hotel_images"].map((x) => HotelImages.fromJson(x))),
      facilities: List<HotelFacilityModel>.from(json["hotel_facilities"].map((x) => HotelFacilityModel.fromJson(x))),
    );
  }

}