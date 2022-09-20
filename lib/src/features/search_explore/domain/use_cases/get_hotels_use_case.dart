import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/hotels_entity.dart';
import '../repository/hotels_repository.dart';

class GetHotelsUseCase implements UseCase<List<HotelsEntity>, NoParams> {
  final HotelsRepository hotelsRepository;

  GetHotelsUseCase({required this.hotelsRepository});

  @override
  Future<Either<Failure, List<HotelsEntity>>> call(params) {
    return hotelsRepository.getHotels();
  }
}