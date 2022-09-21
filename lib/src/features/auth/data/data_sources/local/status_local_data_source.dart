import 'dart:convert';

import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/auth/data/models/status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StatusLocalDataSource {
  Future<StatusModel> getStatus();

  Future<void> cacheStatus(StatusModel statusModel);
}

class StatusLocalDataSourceImpl implements StatusLocalDataSource {
  final SharedPreferences sharedPreferences;

  StatusLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<StatusModel> getStatus() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedLoginStatus);
    if (jsonString != null) {
      final cachedLoginStatus = Future.value(StatusModel.fromJson(json.decode(jsonString)));
      return cachedLoginStatus;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheStatus(StatusModel status) {
    return sharedPreferences.setString(AppStrings.cachedLoginStatus, json.encode(status));
  }
}
