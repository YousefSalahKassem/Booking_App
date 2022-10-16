import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/search_explore/data/model/hotels_model.dart';

abstract class HotelsRemoteDataSource {
  Future<List<HotelsModel>> getHotels();
}

class HotelsRemoteDataSourceImpl implements HotelsRemoteDataSource {
  final ApiConsumer apiConsumer;

  HotelsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<HotelsModel>> getHotels() async {
    final response = await apiConsumer.get(Endpoints.hotels);
    return (response["data"]["data"] as List)
        .map((e) => HotelsModel.fromJson(e, "hotel_facilities"))
        .toList();
  }
}
