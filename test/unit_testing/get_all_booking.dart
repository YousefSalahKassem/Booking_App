import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/features/booking/domain/usecases/get_all_booking_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main () async {
  await di.init();
  test("get all upcoming booking", () async {
    final cubit = GetAllBookingsUseCase(di.sl());
    expectLater(cubit.call("upcomming"), completes);
  });
}