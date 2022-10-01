import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:bookingapp/src/features/booking/data/model/booking_hotel_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());
  LatLngBounds? _visibleRegion;
  Size? _visibleScreenSize;
  GoogleMapController? _mapController;
  List<BookingHotelModel> _bookingHotelList = [];
  List<BookingHotelModel> get hotelList => _bookingHotelList;






}
