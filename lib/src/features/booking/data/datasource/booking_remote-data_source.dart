import 'package:bookingapp/src/core/api/api_consumer.dart';
import 'package:bookingapp/src/core/api/endpoints.dart';
import 'package:bookingapp/src/core/error/exceptions.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_model.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class BookingRemoteDataSource {
  Future<List<Booking>> createBooking(Booking booking);

  Future<List<Booking>> updateBooking(Booking booking);

  Future<List<Booking>> deleteBooking(Booking booking);

  Future<List<Booking>> getAllBookings(String type);
//Future < Either < Failure , Booking >> getBookingById ( String id ) ;
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<Booking>> createBooking(Booking booking) async {
    final response = await Dio().get(Endpoints.getBooking);
    print(response.data);
    if (response.statusCode == 200) {
      return List<Booking>.from((response.data["results"] as List)
          .map((e) => BookingModel.fromJson(e)));
    } else {
      throw const ServerException('Error');
    }
  }

  @override
  Future<List<Booking>> deleteBooking(Booking booking) async {
    final response = await Dio().get(Endpoints.getBooking);
    debugPrint(response.data);
    if (response.statusCode == 200) {
      return List<Booking>.from((response.data["results"] as List)
          .map((e) => BookingModel.fromJson(e)));
    } else {
      throw const ServerException('Error');
    }
  }

  @override
  Future<List<Booking>> getAllBookings( String type) async {
    final response = await apiConsumer
        .get(Endpoints.getBooking, queryParameters: {"type": type});
   //debugPrint(response.data.toString());
    return (response["data"]["data"] as List)
        .map((e) => BookingModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<Booking>> updateBooking(Booking booking) {
    // TODO: implement updateBooking
    throw UnimplementedError();
  }
}
