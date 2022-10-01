import 'dart:async';

import 'package:bookingapp/src/config/animations/animations.dart';
import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/config/themes/app_styles.dart';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  @override
  Widget build(BuildContext context) {
    AppStyles.setSystemOverlay(context);

    return Scaffold(
      body: Center(child: Image.asset(ImageAssets.icon, height: 100)),
    );
  }

  Future<void> _navigateUser() async {
    bool isLoggedIn = await AuthCubit.get(context).getLoginStatus();
    if (isLoggedIn) {
      debugPrint('isLoggedIn = $isLoggedIn');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Routes.homeExploreRoute);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Routes.getStartedRoute);
    }
  }
}
