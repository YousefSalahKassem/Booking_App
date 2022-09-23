import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/config/themes/app_styles.dart';
import 'package:bookingapp/src/config/themes/system/system_overlay_style.dart';
import 'package:bookingapp/src/core/shareable_components/my_button.dart';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/account_check_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStyles.setSystemOverlay(context);
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _buildBackgroundImage(context),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20, left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.paddingTop),
                    _buildTitleImage(),
                    const SizedBox(height: 10),
                    _buildTitleText(),
                    const SizedBox(height: 5),
                    _buildSubtitleText(),
                    const Spacer(),
                    MyButton(
                      text: 'Get started',
                      onPressed: () => Navigator.pushNamed(context, Routes.onBoardingRoute),
                    ),
                    const SizedBox(height: 15),
                    const AccountCheckTextWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildSubtitleText() {
    return const Text(
      'Best hotel deals for your holiday',
      style: TextStyle(fontSize: 17),
    );
  }

  Text _buildTitleText() {
    return const Text(
      'Motel',
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
    );
  }

  Container _buildTitleImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(color: Colors.white, child: Image.asset(ImageAssets.icon, height: 60)),
      ),
    );
  }

  ColorFiltered _buildBackgroundImage(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.softLight),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(ImageAssets.splash),
            fit: BoxFit.cover,
            colorFilter: AppStyles.isDarkMode(context)
                ? ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken)
                : const ColorFilter.mode(Colors.transparent, BlendMode.color),
          ),
        ),
      ),
    );
  }
}
