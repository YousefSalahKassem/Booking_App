import 'package:bookingapp/injection_container.dart' as di;
import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/hotels/hotels_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main () async {
  await di.init();
  group("test filter", () {
    test("search with name", () async {
      final cubit =  HotelsCubit(hotelsUseCase: di.sl() , filterUseCase: di.sl());
      expectLater(cubit.getFilters(FilterModel(
          name: "Nasr Ciry Price 5000",
      )
      ), completes);
    });
    test("search not exist", () async {
      final cubit =  HotelsCubit(hotelsUseCase: di.sl() , filterUseCase: di.sl());
      expectLater(cubit.getFilters(FilterModel(
          name: "Nasr Ciry Price 50000"
      )
      ), completes);
    });
  });
}