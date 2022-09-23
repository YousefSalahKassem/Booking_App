import 'dart:convert';

import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StatusLocalDataSource {
  Future<StatusModel> getStatus();

  Future<bool> cacheStatus(StatusModel statusModel);
}

class StatusLocalDataSourceImpl implements StatusLocalDataSource {
  final SharedPreferences sharedPreferences;

  StatusLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<StatusModel> getStatus() {
    debugPrint('$runtimeType');
    final jsonString = sharedPreferences.getString(AppStrings.cachedLoginStatus);
    debugPrint('jsonString = $jsonString');
    if (jsonString != null) {
      final cachedLoginStatus = Future.value(StatusModel.fromJson(json.decode(jsonString)));
      return cachedLoginStatus;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheStatus(StatusModel status) {
    debugPrint('$runtimeType');
    debugPrint('json.encode(status) = ${json.encode(status)}');
    debugPrint('status.type = ${status.type}');
    return sharedPreferences.setString(AppStrings.cachedLoginStatus, json.encode(status));
  }
}
