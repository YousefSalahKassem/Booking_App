import 'package:bookingapp/src/features/search_explore/domain/entities/facilities_entity.dart';
import 'package:bookingapp/src/features/search_explore/domain/use_cases/get_facilities_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import 'facilities_state.dart';

class FacilitiesCubit extends Cubit<FacilitiesState> {
  final GetFacilitiesUseCase getFacilitiesUseCase;

  FacilitiesCubit({required this.getFacilitiesUseCase}) : super(FacilitiesInitial()){
    getFacilities();
  }

  static FacilitiesCubit get(context) => BlocProvider.of<FacilitiesCubit>(context);

  final List<FacilitiesEntity> facilitiesList = [];

  Future<void> getFacilities() async {
    emit(FacilitiesLoading());
    Either<Failure, List<FacilitiesEntity>> response = await getFacilitiesUseCase(NoParams());
    emit(response.fold(
      (failure) => FacilitiesError(msg: _mapFailureToMsg(failure)),
      (facilities) {
        facilitiesList.addAll(facilities);
        return FacilitiesComplete(facilities: facilities);
      },
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