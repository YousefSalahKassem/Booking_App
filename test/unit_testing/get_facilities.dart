import 'package:bookingapp/src/features/search_explore/presentation/cubit/facilities/facilities_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookingapp/injection_container.dart' as di;

void main () async {
  await di.init();
  test("get facilities", () async {
    final cubit =  FacilitiesCubit(getFacilitiesUseCase: di.sl());
    expectLater(cubit.getFacilities(), completes);
  });
}