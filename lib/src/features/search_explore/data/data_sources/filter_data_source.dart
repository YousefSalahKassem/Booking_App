import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/data/model/hotels_model.dart';

abstract class FilterRemoteDataSource {
  Future<List<HotelsModel>> getFilters(FilterModel filterModel);
}

class FilterRemoteDataSourceImpl implements FilterRemoteDataSource {
  final ApiConsumer apiConsumer;

  FilterRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<HotelsModel>> getFilters(FilterModel filterModel) async {
    final response =
        await apiConsumer.get(Endpoints.searchHotels, queryParameters: filterModel.toJson());
    return (response["data"]["data"] as List)
        .map((e) => HotelsModel.fromJson(e, "facilities"))
        .toList();
  }
}
