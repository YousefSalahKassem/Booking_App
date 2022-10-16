import 'dart:ffi';

import 'package:bookingapp/src/features/booking/data/model/booking_hotel_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());
  LatLngBounds? _visibleRegion;
  Size? _visibleScreenSize;
  GoogleMapController? _mapController;
  final List<BookingHotelModel> _bookingHotelList = [];

  List<BookingHotelModel> get hotelList => _bookingHotelList;
}
