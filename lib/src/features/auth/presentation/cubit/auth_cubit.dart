import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase getAuthUsecase;

  AuthCubit({required this.getAuthUsecase}) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  Future<void> authenticate() async {
    emit(AuthLoading());
    Either<Failure, StatusEntity> response = await getAuthUsecase(NoParams());
    emit(response.fold(
      (failure) => AuthError(msg: _mapFailureToMsg(failure)),
      (auth) => AuthComplete(auth: auth),
    ));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
