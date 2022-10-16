import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/features/booking/presentation/controller/booking_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await di.init();
  final cubit = AllBookingCubit(getAllBookingsUseCase: di.sl());
  test("get all upcoming booking", () async {
    expectLater(cubit.getAllBookings('upcomming'), completes);
  });

  test("get all cancelled booking", () async {
    expectLater(cubit.getAllBookings('cancelled'), completes);
  });

  test("get all completed booking", () async {
    expectLater(cubit.getAllBookings('completed'), completes);
  });
}
