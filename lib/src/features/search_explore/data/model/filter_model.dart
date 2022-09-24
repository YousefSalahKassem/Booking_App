import 'package:bookingapp/src/features/search_explore/domain/entities/filter_entity.dart';

class FilterModel extends FilterEntity{
FilterModel({
    super.name,
    super.address,
    super.latitude,
    super.longitude,
    super.distance,
    super.firstFacility,
    super.secondFacility,
    super.maxPrice,
    super.minPrice
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "max_price": maxPrice,
      "min_price": minPrice,
      "distance": distance,
    };
  }
}