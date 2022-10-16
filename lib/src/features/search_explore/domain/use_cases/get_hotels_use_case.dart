import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/hotels_repository.dart';
import 'package:dartz/dartz.dart';

class GetHotelsUseCase implements UseCase<List<HotelsEntity>, NoParams> {
  final HotelsRepository hotelsRepository;

  GetHotelsUseCase({required this.hotelsRepository});

  @override
  Future<Either<Failure, List<HotelsEntity>>> call(params) {
    return hotelsRepository.getHotels();
  }
}
