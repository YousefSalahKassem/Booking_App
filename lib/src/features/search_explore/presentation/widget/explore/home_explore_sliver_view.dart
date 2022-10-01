import 'dart:async';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../config/themes/app_themes.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../domain/entities/page_view_entity.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView(
      {Key? key, this.opValue = 0.0, required this.click})
      : super(key: key);
  @override
  _HomeExploreSliderViewState createState() => _HomeExploreSliderViewState();
}

class _HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: 'cape Town',
      subText: 'five star',
      assetsImage: ImageAssets.france,
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'find best deals',
      subText: 'five star',
      assetsImage: ImageAssets.germany,
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'find best deals',
      subText: 'five star',
      assetsImage: ImageAssets.italy,
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        if (currentShowIndex == 0) {
          pageController.animateTo(MediaQuery
              .of(context)
              .size
              .width,
              duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 1) {
          pageController.animateTo(MediaQuery
              .of(context)
              .size
              .width * 2,
              duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 2) {
          pageController.animateTo(0,
              duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
      }});
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              PagePopup(
                imageData: pageViewModelData[0],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[1],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[2],
                opValue: widget.opValue,
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: SmoothPageIndicator(
                controller: pageController, // PageController
                count: 3,
                effect: WormEffect(
                    activeDotColor:const Color(0xFF4FBE9F),
                    dotColor: Theme.of(context).dividerColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0), // your preferred effect
                onDotClicked: (index) {}),
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;

  const PagePopup({Key? key, required this.imageData, this.opValue = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData.assetsImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 2  4,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  imageData.titleText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context)
                      .getTitleStyle()
                      .copyWith(color: AppTheme.whiteColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  imageData.subText,
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.whiteColor),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
