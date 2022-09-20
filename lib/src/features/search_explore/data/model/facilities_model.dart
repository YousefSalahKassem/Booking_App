import 'package:bookingapp/src/features/search_explore/domain/entities/facilities_entity.dart';

class FacilitiesModel extends FacilitiesEntity {
  FacilitiesModel({
    required final String name,
    required final String image,
    required final int id,
  }) : super(name: name, image: image, id: id);

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) {
    return FacilitiesModel(
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
      id: json["facility_id"],
    );
  }
}
