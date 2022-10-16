import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StatusLocalDataSource {
  Future<bool> getLoginStatus();

  Future<bool> cacheStatus();
}

/// implementation of local data source
/// depending on shared_preferences package
class StatusLocalDataSourceImpl implements StatusLocalDataSource {
  final SharedPreferences sharedPreferences;

  StatusLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> getLoginStatus() async {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============getLoginStatus==============');
    debugPrint('$runtimeType');
    bool isLoggedIn = false;
    debugPrint('isLoggedIn = $isLoggedIn');
    debugPrint(
        'sharedPreferences.getBool(AppStrings.cachedLoginStatus) = ${sharedPreferences.getBool(AppStrings.cachedLoginStatus)}');
    isLoggedIn = sharedPreferences.getBool(AppStrings.cachedLoginStatus) != null;
    debugPrint('isLoggedIn = $isLoggedIn');
    return isLoggedIn;
  }

  @override
  Future<bool> cacheStatus() async {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============cacheStatus==============');
    debugPrint('$runtimeType');
    debugPrint(
        "sharedPreferences.getString(AppStrings.cachedApiToken) != null = ${sharedPreferences.getString(AppStrings.cachedApiToken) != null}");
    return await sharedPreferences.setBool(AppStrings.cachedLoginStatus,
        sharedPreferences.getString(AppStrings.cachedApiToken) != null);
  }
}
