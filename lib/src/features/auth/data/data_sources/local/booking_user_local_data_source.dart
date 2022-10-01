import 'dart:convert';

import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookingUserLocalDataSource {
  Future<BookingUserModel> getUserData();

  Future<bool> cacheUserData(BookingUserModel bookingUserModel);

  Future<String?> getApiToken();

  Future<bool> cacheApiToken(BookingUserModel bookingUserModel);
}

class BookingUserLocalDataSourceImpl implements BookingUserLocalDataSource {
  final SharedPreferences sharedPreferences;

  BookingUserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<BookingUserModel> getUserData() {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============getUserData==============');
    debugPrint('$runtimeType');
    final jsonString = sharedPreferences.getString(AppStrings.cachedUserData);
    debugPrint('jsonString = $jsonString');
    if (jsonString != null) {
      final cachedUserData = Future.value(BookingUserModel.fromJson(json.decode(jsonString)));
      return cachedUserData;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheUserData(BookingUserModel bookingUserModel) {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============cacheUserData==============');
    debugPrint('$runtimeType');
    debugPrint('json.encode(bookingUserModel) = ${json.encode(bookingUserModel)}');
    debugPrint('bookingUserModel.userId = ${bookingUserModel.userId}');
    debugPrint('bookingUserModel.image = ${bookingUserModel.image}');
    debugPrint('bookingUserModel.name = ${bookingUserModel.name}');
    debugPrint('bookingUserModel.email = ${bookingUserModel.email}');
    debugPrint('bookingUserModel.apiToken = ${bookingUserModel.apiToken}');
    debugPrint('bookingUserModel.createdAt = ${bookingUserModel.createdAt}');
    debugPrint('bookingUserModel.updatedAt = ${bookingUserModel.updatedAt}');
    return sharedPreferences.setString(AppStrings.cachedUserData, json.encode(bookingUserModel));
  }

  @override
  Future<String?> getApiToken() {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============getUserData==============');
    debugPrint('$runtimeType');
    final jsonString = sharedPreferences.getString(AppStrings.cachedApiToken);
    debugPrint('jsonString = $jsonString');
    if (jsonString != null) {
      final cachedApiToken =
          Future.value(BookingUserModel.fromJson(json.decode(jsonString)).apiToken);
      return cachedApiToken;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheApiToken(BookingUserModel bookingUserModel) {
    debugPrint('===============SharedPreferences==============');
    debugPrint('===============cacheUserData==============');
    debugPrint('$runtimeType');
    debugPrint(
        'json.encode(bookingUserModel.apiToken) = ${json.encode(bookingUserModel.apiToken)}');
    debugPrint('bookingUserModel.apiToken = ${bookingUserModel.apiToken}');
    return sharedPreferences.setString(
        AppStrings.cachedApiToken, json.encode(bookingUserModel.apiToken));
  }
}
