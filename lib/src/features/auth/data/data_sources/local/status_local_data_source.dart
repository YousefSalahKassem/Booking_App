import 'dart:convert';

import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StatusLocalDataSource {
  Future<bool?> getLoginStatus();

  Future<bool> cacheStatus(BookingUserModel bookingUserModel);
}

class StatusLocalDataSourceImpl implements StatusLocalDataSource {
  final SharedPreferences sharedPreferences;

  StatusLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool?> getLoginStatus() async {
    // using apiToken
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============getLoginStatus==============');
    debugPrint('$runtimeType');
    final json = sharedPreferences.getBool(AppStrings.cachedLoginStatus);
    debugPrint('jsonString = $json');
    if (json != false) {
      // final cachedLoginStatus =
      // Future.value(BookingUserModel.fromJson(json.decode(json)).apiToken?.isNotEmpty);
      return json;
    } else {
      throw CacheException();
    }
  }

  // FIXME: error encoding because StatusModel has no [toJson()] function
  @override
  Future<bool> cacheStatus(BookingUserModel bookingUserModel) {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============cacheStatus==============');
    debugPrint('$runtimeType');
    debugPrint('json.encode(status) = ${json.encode(bookingUserModel)}');
    debugPrint('status.apiToken = ${bookingUserModel.apiToken}');
    return sharedPreferences.setBool(
        AppStrings.cachedLoginStatus, json.encode(bookingUserModel.apiToken).isNotEmpty);
  }
}
