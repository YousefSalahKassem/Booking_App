import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/login_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/register_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/get_started_screen.dart';
import 'package:bookingapp/src/features/auth/presentation/screens/splash_screen.dart';
import 'package:bookingapp/src/features/booking/presentation/components/map_and_list_view.dart';
import 'package:bookingapp/src/features/booking/presentation/screens/all_my_booking_screen.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/bottom_tap/bottom_tab_screen.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/filter_screen/filters_screen.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/hotel_booking/hotel_home_screen.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/hotel_details/search_screen.dart';
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
  static const String homeExploreRoute = '/homeExplore';
  static const String searchRoute = '/search';
  static const String hotelHomeScreenRoute = '/hotelHomeScreen';
  static const String filterScreenRoute = '/filterScreenRoute';
  static const String hotelDetailsScreenRoute = '/hotelDetailsScreenRoute';
  static const String roomBookingScreenRoute = '/roomBookingScreenRoute';
  static const String bookingScreenRoute = '/bookingScreenRoute';
  static const String allMyBookingScreenRoute = '/allMyBookingScreenRoute';
  static const String mapScreenRoute = '/mapScreenRoute';
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
        case Routes.homeExploreRoute:
        return MaterialPageRoute(builder: ((context) {
          return const BottomTabScreen();
        }));
        case Routes.searchRoute:
        return MaterialPageRoute(builder: ((context) {
          return const SearchScreen();
        }));

        case Routes.hotelHomeScreenRoute:
        return MaterialPageRoute(builder: ((context) {
          return const HotelHomeScreen();
        }));
              case Routes.filterScreenRoute:
        return MaterialPageRoute(builder: ((context) {
          return const FiltersScreen();
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(
      builder: (context) => const Scaffold(body: Center(child: Text(Routes.noRouteFound))));
}
