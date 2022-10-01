import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/shareable_components/common_card.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/utils/text_styles.dart';

class MapHotelListView extends StatelessWidget {
  final VoidCallback callback;
  final HotelsEntity hotelData;

  const MapHotelListView(
      {Key? key, required this.hotelData, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 16),
      child: CommonCard(
        radius: 16,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: AspectRatio(
            aspectRatio: 2.7,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.90,
                      child: Image.network(
                        "http://api.mahmoudtaha.com/images/${hotelData.images[0].image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              hotelData.name,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyles(context).getBoldStyle().copyWith(
                                        fontSize: 16,
                                      ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              hotelData.address,
                              maxLines: 1,
                              style: TextStyles(context)
                                  .getDescriptionStyle()
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Helper.ratingStar(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "\$${hotelData.price}",
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(
                                              fontSize: 22,
                                            ),
                                      ),
                                      Text(
                                        "Per night",
                                        style: TextStyles(context)
                                            .getDescriptionStyle()
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                      callback();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
