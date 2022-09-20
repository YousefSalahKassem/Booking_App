import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/login_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/test_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookingapp/injection_container.dart' as di;

class Routes {
  static const String initialRoute = '';
  static const String noRouteFound = 'No Route Found';
  static const String testHomeRoute = 'test';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => di.sl<AuthCubit>()),
            child: const LoginScreen(),
          );
        }));
      // TODO: to be removed
      case Routes.testHomeRoute:
        return MaterialPageRoute(builder: ((context) {
          return const TestHomeScreen();
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(
      builder: (context) => const Scaffold(body: Center(child: Text(Routes.noRouteFound))));
}
