import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/core/utils/text_styles.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotel_list_data.dart';
import 'package:flutter/material.dart';

class RatingView extends StatelessWidget {
  final HotelListData hotelData;

  const RatingView({Key? key, required this.hotelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: context.width30 * 5,
                    child: Text(
                      (hotelData.rating * 2).toStringAsFixed(1),
                      textAlign: TextAlign.left,
                      style: TextStyles(context)
                          .getBoldStyle()
                          .copyWith(fontSize: 38, color: AppColors.primary),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Rating",
                          textAlign: TextAlign.left,
                          style: TextStyles(context).getRegularStyle().copyWith(
                                // fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Theme.of(context).disabledColor.withOpacity(0.8),
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            getBarUI('room', 95.0, context),
            const SizedBox(
              height: 4,
            ),
            getBarUI('service', 80.0, context),
            const SizedBox(
              height: 4,
            ),
            getBarUI('location', 65.0, context),
            const SizedBox(
              height: 4,
            ),
            getBarUI('price', 85, context),
          ],
        ),
      ),
    );
  }

  Widget getBarUI(String text, double percent, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 60,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyles(context).getRegularStyle().copyWith(
                    // fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Theme.of(context).disabledColor.withOpacity(0.8),
                  ),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 7,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: percent.toInt(),
                child: const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: SizedBox(
                      height: 4,
                      child: CommonCard(
                        color: AppColors.primary,
                        radius: 8,
                      ),
                    )),
              ),
              Expanded(
                flex: 100 - percent.toInt(),
                child: const SizedBox(),
              )
            ],
          ),
        )
      ],
    );
  }
}
