import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:bookingapp/src/features/profile/domain/usecases/update_info_use_case.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_user_info_use_case.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateInfoUseCase updateUser;
  final GetUserInfoUseCase getUserInfo;
  UpdateUserCubit({required this.updateUser, required this.getUserInfo}) : super(UpdateUserInitial());

  Future<void> updateInfo(UpdateInfoModel updateInfoEntity) async {
    emit(UpdateUserLoading());
    final result = await updateUser(updateInfoEntity);
    result.fold(
      (failure) => emit(UpdateUserFailure(message: _mapFailureToMessage(failure))),
      (success) => emit(UpdateUserSuccess(updateInfoEntity: success)),
    );
  }

  Future<void> userProfile() async {
    emit(UpdateUserLoading());
    final result = await getUserInfo.call(NoParams());
    result.fold(
      (failure) => emit(UpdateUserFailure(message: _mapFailureToMessage(failure))),
      (success) => emit(UpdateUserSuccess(updateInfoEntity: success)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}