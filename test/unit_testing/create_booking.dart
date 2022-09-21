import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/create_booking/booking_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookingapp/injection_container.dart' as di;

void main () async {
  await di.init();
  final cubit = BookingCubit(createBookingUseCase: di.sl(), updateBookingUseCase: di.sl());
  group("check booking", () {
    test("create booking successfully", () async {
      expectLater(cubit.createBooking(CreateBookingModel(hotelId: "15")), completes);
    });
    test("create booking failed", () async {
      expectLater(cubit.createBooking(CreateBookingModel(hotelId: "100")), completes);
    });
  });
}