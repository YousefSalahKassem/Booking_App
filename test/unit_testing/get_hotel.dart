import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/features/search_explore/presentation/cubit/hotels/hotels_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main () async {
  await di.init();
  test("get hotels", () async {
    final cubit =  HotelsCubit(hotelsUseCase: di.sl());
    expectLater(cubit.getHotels(), completes);
  });
}