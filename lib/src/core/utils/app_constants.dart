import 'package:bookingapp/src/core/utils/app_strings.dart';
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

  /// validation

  // name
  static bool nameMatchesLength(String? value) => value!.length >= 3;
  static bool nameContainsSpaces(String? value) => value!.contains(' ');
  static bool nameContainsSpChar(String? value) =>
      RegExp(AppStrings.oneSpCharRegExp).hasMatch(value!);
  static bool nameContainsNums(String? value) =>
      value!.contains('0') ||
      value.contains('1') ||
      value.contains('2') ||
      value.contains('3') ||
      value.contains('4') ||
      value.contains('5') ||
      value.contains('6') ||
      value.contains('7') ||
      value.contains('8') ||
      value.contains('9');

// email
  static bool emailContainsSpaces(String? value) => value!.contains(' ');

  static bool emailFormValid(String? value) =>
      RegExp(AppStrings.emailRegExp, caseSensitive: false).hasMatch(value!);

// password
  static bool passContainsOneUppercase(String? value) =>
      RegExp(AppStrings.twoUppercaseRegExp).hasMatch(value!);
  static bool passContainsOneLowercase(String? value) =>
      RegExp(AppStrings.twoLowercaseRegExp).hasMatch(value!);
  static bool passContainsOneNum(String? value) => RegExp(AppStrings.twoNumRegExp).hasMatch(value!);
  static bool passContainsOneSpChar(String? value) =>
      RegExp(AppStrings.twoSpCharRegExp).hasMatch(value!);
  static bool passMatchesLength(String? value) => value!.length >= 6;

  // password confirmation
  static bool passesAreIdentical(String? value, String? password) => value! == password!;
}
