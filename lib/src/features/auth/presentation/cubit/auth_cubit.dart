import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/get_login_status_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/log_in_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/register_usecase.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetLoginStatusUseCase getLoginStatusUseCase;
  final LogInUseCase logInUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.getLoginStatusUseCase,
    required this.logInUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  bool isLoggedIn = false;
  bool isRegistered = false;

  Future<bool> getLoginStatus() async {
    emit(StatusLoading());
    Either<Failure, bool> response = await getLoginStatusUseCase(NoParams());
    emit(
      response.fold(
        (failure) => AuthError(msg: _mapFailureToMsg(failure)),
        (loggedIn) {
          debugPrint('loggedIn = $loggedIn');
          isLoggedIn = loggedIn;
          debugPrint('isLoggedIn = $isLoggedIn');
          return StatusSuccess(isLoggedIn: loggedIn);
        },
      ),
    );
    return isLoggedIn;
  }

  Future<bool> logIn(LoginModel loginModel, BuildContext context) async {
    emit(LoginLoading());
    Either<Failure, BookingUser> response = await logInUseCase(loginModel);
    emit(response.fold(
      (failure) => AuthError(msg: _mapFailureToMsg(failure)),
      (user) {
        if (user.apiToken != null) {
          isLoggedIn = true;
        }
        return LoginSuccess(user: user);
      },
    ));
    return isLoggedIn;
  }

  Future<bool> register(RegisterModel registerModel) async {
    emit(RegisterLoading());
    Either<Failure, BookingUser> userResponse = await registerUseCase(registerModel);
    emit(
      userResponse.fold(
        (failure) => AuthError(msg: _mapFailureToMsg(failure)),
        (user) {
          if (user.apiToken != null) {
            isRegistered = true;
          }
          return RegisterSuccess(user: user);
        },
      ),
    );
    return isRegistered;
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

  void navigateUser(BuildContext context) {
    debugPrint('navigateUser function => isLoggedIn = $isLoggedIn, isRegistered = $isRegistered');
    if (isLoggedIn || isRegistered) {
      Navigator.pushReplacementNamed(context, Routes.homeExploreRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.getStartedRoute);
    }
  }

  void navigateToHomeScreen(BuildContext context) {
    debugPrint(
        'navigateToHomeScreen function => isLoggedIn = $isLoggedIn, isRegistered = $isRegistered');
    if (isLoggedIn || isRegistered) {
      Navigator.pushReplacementNamed(context, Routes.homeExploreRoute);
    } else {
      emit(const AuthError(msg: 'AuthError'));
    }
  }
}
