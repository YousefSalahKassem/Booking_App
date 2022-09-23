import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_hotels_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/hotels_entity.dart';
import '../../../domain/use_cases/get_filter_use_case.dart';
import 'hotels_state.dart';

class HotelsCubit extends Cubit<HotelsState> {
  final GetHotelsUseCase hotelsUseCase;
  final GetFilterUseCase filterUseCase;
  HotelsCubit({required this.hotelsUseCase , required this.filterUseCase}) : super(HotelsInitial()){
    getHotels();
  }

  Future<void> getHotels() async {
    emit(HotelsLoading());
    Either <Failure, List<HotelsEntity>> response = await hotelsUseCase(NoParams());
    emit(response.fold(
      (failure) => HotelsError(msg: _mapFailureToMsg(failure)),
      (hotels) => HotelsComplete(hotels: hotels),
    ));
  }

  Future<void> getFilters(FilterModel filterModel) async {
    emit(HotelsLoading());
    Either <Failure, List<HotelsEntity>> response = await filterUseCase(filterModel);
    emit(response.fold(
      (failure) => HotelsError(msg: _mapFailureToMsg(failure)),
      (hotels) => HotelsComplete(hotels: hotels),
    ));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}