import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/features/search_explore/data/model/update_booking_model.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/create_booking/booking_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main () async {
  await di.init();
  final cubit = BookingCubit(createBookingUseCase: di.sl(), updateBookingUseCase: di.sl());
  group("update booking", () {
    test("update booking successfully", () async {
      expectLater(cubit.updateBooking(UpdateBookingModel(hotelId: "7",type: "canceled")), completes);
    });
    test("update booking failed", () async {
      expectLater(cubit.updateBooking(UpdateBookingModel(hotelId: "1000",type: "completed")), completes);
    });
  });
}