import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/shareable_components/list_cell_animation_view.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/helper.dart';
import 'package:bookingapp/src/core/utils/text_styles.dart';
import 'package:bookingapp/src/features/booking/domain/entity/booking.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotel_list_data.dart';
import 'package:flutter/material.dart';

class BookingListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final Booking bookingData;
  final AnimationController animationController;
  final Animation<double> animation;

  const BookingListView(
      {Key? key,
      required this.bookingData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListCellAnimationView(
        animation: animation,
        animationController: animationController,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Column(
            children: <Widget>[
              isShowDate
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Helper.getDateText(HotelListData.hotelList[0].date!)}, ',
                            style: TextStyles(context).getRegularStyle().copyWith(fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              Helper.getRoomText(HotelListData.hotelList[0].roomData!),
                              style: TextStyles(context).getRegularStyle().copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              CommonCard(
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
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        bookingData.hotel.name,
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(fontSize: 22),
                                      ),
                                      Text(
                                        bookingData.hotel.address,
                                        style: TextStyles(context).getDescriptionStyle(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: <Widget>[
                                            Helper.ratingStar(),
                                            Text(
                                              " ${HotelListData.hotelList[0].reviews}",
                                              style: TextStyles(context).getDescriptionStyle(),
                                            ),
                                            Text(
                                              "reviews",
                                              style: TextStyles(context).getDescriptionStyle(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16, top: 8, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "\$${bookingData.hotel.price}",
                                      textAlign: TextAlign.left,
                                      style:
                                          TextStyles(context).getBoldStyle().copyWith(fontSize: 22),
                                    ),
                                    Text(
                                      "/per night",
                                      style: TextStyles(context).getDescriptionStyle(),
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
                            splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            onTap: () {
                              try {
                                callback();
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor, shape: BoxShape.circle),
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
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
