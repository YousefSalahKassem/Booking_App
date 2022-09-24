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
    AuthCubit.get(context).getLoginData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(ImageAssets.icon, height: 100)),
    );
  }
}
