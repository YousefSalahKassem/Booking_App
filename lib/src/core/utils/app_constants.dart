import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/pager_widget.dart';

class AppConstants {
  static List<PageData> onBoardingPages = [
    PageData(
      title: 'Plan your trips',
      subtitle: 'book one of our unique hotels to escape the ordinary',
      image: ImageAssets.onBoarding1,
    ),
    PageData(
      title: 'Find best deals',
      subtitle: 'find deals for any season from cosy country homes to city flats',
      image: ImageAssets.onBoarding2,
    ),
    PageData(
      title: 'Best travelling all time',
      subtitle: 'find deals for any season from cosy country homes to city flats',
      image: ImageAssets.onBoarding3,
    ),
  ];
}
