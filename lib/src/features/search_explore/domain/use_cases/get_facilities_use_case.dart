import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/facilities_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/facilities_repository.dart';

class GetFacilitiesUseCase implements UseCase<List<FacilitiesEntity>, NoParams> {
  final FacilitiesRepository facilitiesRepository;

  GetFacilitiesUseCase({required this.facilitiesRepository});

  @override
  Future<Either<Failure, List<FacilitiesEntity>>> call(params) {
    return facilitiesRepository.getFacilities();
  }
}