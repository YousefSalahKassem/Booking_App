import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/filter_entity.dart';
import '../repository/filter_repository.dart';

class GetFilterUseCase implements UseCase<List<HotelsEntity>, FilterModel> {
  final FilterRepository filterRepository;

  GetFilterUseCase({required this.filterRepository});

  @override
  Future<Either<Failure, List<HotelsEntity>>> call(params) {
    return filterRepository.getFilters(params);
  }
}