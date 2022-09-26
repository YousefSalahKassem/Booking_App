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

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fadeInOutAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStyles.setSystemOverlay(context);

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: _buildSplashImage(),
        ),
      ),
    );
  }

  Widget _buildSplashImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(color: Colors.white, child: Image.asset(ImageAssets.icon, height: 80)),
    );
  }

  void _fadeInOutAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 1.0, end: 0.2).animate(_animationController);
    Animations.continuousReversibleAnimation(_animationController, _animation);
  }

  void _startTimer() => Timer(const Duration(seconds: 3), () => _navigateUser());

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
