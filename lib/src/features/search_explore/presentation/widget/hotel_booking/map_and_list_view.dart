import 'package:bookingapp/src/features/search_explore/presentation/widget/hotel_booking/time_date_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/hotel_list_data.dart';
import '../../cubit/hotels/hotels_cubit.dart';
import '../../cubit/hotels/hotels_state.dart';
import '../../pages/hotel_booking/map_hotel_view.dart';

class MapAndListView extends StatelessWidget {
  final List<HotelListData> hotelList;
  final Widget searchBarUI;

  const MapAndListView(
      {Key? key, required this.hotelList, required this.searchBarUI})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StatefulBuilder(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              searchBarUI,
              const TimeDateView(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // GoogleMapUIView(
                    //   hotelList: hotelList,
                    // ),
                    IgnorePointer(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(1.0),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.4),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                        height: 156,
                        // color: Colors.green,
                        child: BlocBuilder<HotelsCubit,HotelsState>(builder: (context,state){
                          if (state is HotelsComplete) {
                            return ListView.builder(
                              itemCount: state.hotels.length,
                              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return MapHotelListView(
                                  callback: () {
                                  },
                                  hotelData: state.hotels[index],
                                );
                              },
                            );
                          }
                          else {
                            return const SizedBox();
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
