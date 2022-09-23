import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/entities/status_entity.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/get_status_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/log_in_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetStatusUseCase getStatusUsecase;
  final LogInUseCase logInUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.getStatusUsecase,
    required this.logInUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  bool? isLoggedIn;

  Future<void> getLoginStatus() async {
    emit(StatusLoading());
    Either<Failure, StatusEntity> response = await getStatusUsecase(NoParams());
    emit(response.fold(
      (failure) => AuthError(msg: _mapFailureToMsg(failure)),
      (status) {
        var state = StatusComplete(status: status);
        if (status.type == '1') {
          isLoggedIn = true;
        }
        return state;
      },
    ));
  }

  Future<void> logIn(LoginModel loginModel) async {
    emit(LoginLoading());
    Either<Failure, StatusEntity> response = await logInUseCase(loginModel);
    emit(response.fold(
      (failure) => AuthError(msg: _mapFailureToMsg(failure)),
      (login) {
        var state = LoginComplete(status: login);
        if (login.type == '1') {
          isLoggedIn = true;
        }
        return state;
      },
    ));
  }

  Future<void> register(RegisterModel registerModel) async {
    emit(RegisterLoading());
    Either<Failure, StatusEntity> response = await registerUseCase(registerModel);
    emit(response.fold(
      (failure) => AuthError(msg: _mapFailureToMsg(failure)),
      (register) => RegisterComplete(status: register),
    ));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }

  void navigateToTestHome(BuildContext context) {
    if (isLoggedIn == true) {
      Navigator.pushNamed(context, Routes.initialRoute);
    }
  }
}
