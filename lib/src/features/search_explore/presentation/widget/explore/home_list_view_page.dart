import 'package:bookingapp/src/features/search_explore/domain/entities/hotel_list_data.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import '../../../../../core/shareable_components/common_card.dart';
import '../../../../../core/shareable_components/list_cell_animation_view.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/utils/text_styles.dart';

class HotelListViewPage extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelsEntity hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListViewPage(
      {Key? key,
      required this.hotelData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: CommonCard(
          child: ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child: AspectRatio(
              aspectRatio: 2.7,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 0.90,
                        child: CachedNetworkImage(
                          imageUrl: "http://api.mahmoudtaha.com/images/${hotelData.images[0].image}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width >= 360
                                  ? 12
                                  : 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                hotelData.name,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyles(context)
                                    .getBoldStyle()
                                    .copyWith(
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                hotelData.address,
                                maxLines: 2,
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Helper.ratingStar(),
                                        ],
                                      ),
                                    ),
                                    FittedBox(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(right: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "\$${hotelData.price}",
                                              textAlign: TextAlign.left,
                                              style: TextStyles(context)
                                                  .getBoldStyle()
                                                  .copyWith(fontSize: 22),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2),
                                              child: Text(
                                                "/per night",
                                                style: TextStyles(context)
                                                    .getDescriptionStyle()
                                                    .copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try {
                          callback();
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
