import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/features/search_explore/data/model/facilities_model.dart';

abstract class FacilitiesRemoteDataSource {
  Future<List<FacilitiesModel>> getFacilities();
}

class FacilitiesRemoteDataSourceImpl implements FacilitiesRemoteDataSource {
  final ApiConsumer apiConsumer;

  FacilitiesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<FacilitiesModel>> getFacilities() async {
    final response = await apiConsumer.get(Endpoints.facilities);
    return (response["data"] as List).map((e) => FacilitiesModel.fromJson(e)).toList();
  }
}
