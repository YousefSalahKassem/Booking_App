import 'package:bookingapp/src/features/search_explore/data/model/hotel_images.dart';

import '../../data/model/facilities_model.dart';

class HotelsEntity {
  final int id;
  final String name;
  final String description;
  final String price;
  final String address;
  final String latitude;
  final String longitude;
  final List<HotelImages> images;
  final List<HotelFacilityModel> facilities;

  const HotelsEntity({
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