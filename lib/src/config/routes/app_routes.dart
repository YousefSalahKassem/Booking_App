import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/login_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/register_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/get_started_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookingapp/injection_container.dart' as di;

class Routes {
  static const String initialRoute = '/';
  static const String noRouteFound = 'No Route Found';
  static const String getStartedRoute = '/getstarted';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String onBoardingRoute = '/onboarding';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => di.sl<AuthCubit>()),
            child: const SplashScreen(),
          );
        }));
      case Routes.getStartedRoute:
        return MaterialPageRoute(builder: ((context) => const GetStartedScreen()));
      case Routes.loginRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => di.sl<AuthCubit>()),
            child: const LoginScreen(),
          );
        }));
      case Routes.registerRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => di.sl<AuthCubit>()),
            child: const RegisterScreen(),
          );
        }));
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: ((context) {
          return const OnBoardingScreen();
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(
      builder: (context) => const Scaffold(body: Center(child: Text(Routes.noRouteFound))));
}
