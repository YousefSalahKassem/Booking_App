import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/config/themes/app_themes.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/hotels/hotels_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
BuildContext? applicationcontext;

class BookingApp extends StatelessWidget {
  const BookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(create: (context) => di.sl<HotelsCubit>()),
        // TODO: add a LocaleCubit provider
      ],
      // TODO: surround MaterialApp with LocaleCubit builder
      child: MaterialApp(
        title: AppStrings.appName,
        themeMode: ThemeMode.system,
        theme: AppTheme.getThemeData(true),
        darkTheme: AppTheme.getThemeData(false),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
