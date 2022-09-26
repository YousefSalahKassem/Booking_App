import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/core/usecases/usecase.dart';
import 'package:bookingapp/src/core/error/failures.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/data/data_sources/local/status_local_data_source.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/data/models/register_model.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/get_status_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/log_in_usecase.dart';
import 'package:bookingapp/src/features/auth/domain/use_cases/register_usecase.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookingapp/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final StatusLocalDataSource statusLocalDataSource;
  final LogInUseCase logInUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.statusLocalDataSource,
    required this.logInUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  bool isLoggedIn = false;
  bool isRegistered = false;

  Future<bool> getLoginData(BuildContext context) async {
    statusLocalDataSource.getLoginStatus().then((loggedIn) {
      debugPrint('loggedIn = $loggedIn');
      if (loggedIn==true) {

      //  isLoggedIn = loggedIn!;
        navigateToHomeScreen(context);
      } else {
        Navigator.pushNamed(context, Routes.homeExploreRoute);
      }
    });
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

  void navigateToHomeScreen(BuildContext context) {
    if (isLoggedIn == true || isRegistered == true) {
      Navigator.pushNamed(context, Routes.onBoardingRoute); // TODO: change to home screen
    }
  }
}
