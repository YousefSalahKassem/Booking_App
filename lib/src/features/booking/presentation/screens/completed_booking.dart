import 'package:bookingapp/src/features/booking/presentation/controller/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shareable_components/common_card.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../search_explore/domain/entities/hotel_list_data.dart';


class CompletedBooking extends StatefulWidget {
  const CompletedBooking({Key? key}) : super(key: key);

  @override
  State<CompletedBooking> createState() => _CompletedBookingState();
}

class _CompletedBookingState extends State<CompletedBooking> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    AllBookingCubit.get(context).getAllBookings('completed');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBookingCubit, AllBookingState>(
      builder: (context, state) {
        if (state is AllBookingStatusComplete) {
          return ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              return CommonCard(
                radius: 16,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 2,
                            child: Image.asset(
                              HotelListData.hotelList[0].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 8, bottom: 8, right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        state.completedBookings[index].hotel.name,
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 22),
                                      ),
                                      Text(
                                        state.completedBookings[index].hotel.address,
                                        style: TextStyles(context)
                                            .getDescriptionStyle(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: <Widget>[
                                            Helper.ratingStar(),
                                            Text(
                                              " ${HotelListData.hotelList[0].reviews}",
                                              style: TextStyles(context)
                                                  .getDescriptionStyle(),
                                            ),
                                            Text(
                                              "reviews",
                                              style: TextStyles(context)
                                                  .getDescriptionStyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, top: 8, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "\$${state.completedBookings[index].hotel.price}",
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(fontSize: 22),
                                    ),
                                    Text(
                                      "/per night",
                                      style: TextStyles(context)
                                          .getDescriptionStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        left: 0,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              onTap: () { }

                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              shape: BoxShape.circle),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );

            },
            itemCount: state.completedBookings.length,
          );
        }
        return Container();
      },
    );
  }
}
