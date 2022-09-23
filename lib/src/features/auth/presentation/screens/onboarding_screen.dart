import 'dart:async';

import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/config/themes/app_styles.dart';
import 'package:bookingapp/src/core/shareable_components/my_button.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/app_constants.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/pager_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController(initialPage: 0);
  late Timer sliderTimer;
  int _currentShowIndex = 0;

  @override
  void initState() {
    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentShowIndex == 0) {
        _pageController.animateTo(context.width,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentShowIndex == 1) {
        _pageController.animateTo(context.width * 2,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentShowIndex == 2) {
        _pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyContent(),
    );
  }

  Column _buildBodyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: context.paddingTop),
        _buildPager(),
        _buildPageIndicator(),
        _buildPageButtons(context),
        SizedBox(height: context.paddingBottom),
      ],
    );
  }

  Padding _buildPageButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          MyButton(
            text: 'Log in',
            onPressed: () => Navigator.pushNamed(context, Routes.loginRoute),
          ),
          const SizedBox(height: 15),
          MyButton(
            text: 'Create account',
            onPressed: () => Navigator.pushNamed(context, Routes.registerRoute),
            backgroundColor:
                AppStyles.isLightMode(context) ? Colors.white : AppColors.textFieldDark,
          ),
        ],
      ),
    );
  }

  SmoothPageIndicator _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: _pageController, // PageController
      count: 3,
      effect: WormEffect(
        activeDotColor: AppColors.buttonGreen,
        dotColor:
            AppStyles.isLightMode(context) ? AppColors.hintColorLight : AppColors.textFieldDark,
        dotHeight: 10,
        dotWidth: 10,
        spacing: 5,
      ),
    );
  }

  Expanded _buildPager() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        pageSnapping: true,
        onPageChanged: (index) => _currentShowIndex = index,
        scrollDirection: Axis.horizontal,
        children: [
          PagePopup(data: AppConstants.onBoardingPages[0]),
          PagePopup(data: AppConstants.onBoardingPages[1]),
          PagePopup(data: AppConstants.onBoardingPages[2]),
        ],
      ),
    );
  }
}
