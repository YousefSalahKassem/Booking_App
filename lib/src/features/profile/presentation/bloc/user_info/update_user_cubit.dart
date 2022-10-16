import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:bookingapp/src/features/profile/domain/entity/update_info_entity.dart';
import 'package:bookingapp/src/features/profile/domain/usecases/get_user_info_use_case.dart';
import 'package:bookingapp/src/features/profile/domain/usecases/update_user_info_use_case.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUserInfoUseCase updateUserUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;

  UpdateUserCubit({required this.updateUserUseCase, required this.getUserInfoUseCase})
      : super(UpdateUserInitial()) {
    userProfile();
  }

  final userInfo = UpdateInfoEntity(name: '', email: '');

  Future<void> updateInfo(UpdateInfoModel updateInfoEntity) async {
    emit(UpdateUserLoading());
    final result = await updateUserUseCase(updateInfoEntity);
    result.fold(
      (failure) => emit(UpdateUserFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(UpdateUserSuccess(user: user)),
    );
  }

  Future<void> userProfile() async {
    emit(UpdateUserLoading());
    final result = await getUserInfoUseCase.call(NoParams());
    result.fold(
      (failure) => emit(UpdateUserFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(UpdateUserSuccess(user: user)),
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
