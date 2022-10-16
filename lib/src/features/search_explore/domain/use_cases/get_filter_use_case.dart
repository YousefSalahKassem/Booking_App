import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/repository/filter_repository.dart';
import 'package:dartz/dartz.dart';

class GetFilterUseCase implements UseCase<List<HotelsEntity>, FilterModel> {
  final FilterRepository filterRepository;

  GetFilterUseCase({required this.filterRepository});

  @override
  Future<Either<Failure, List<HotelsEntity>>> call(params) {
    return filterRepository.getFilters(params);
  }
}
