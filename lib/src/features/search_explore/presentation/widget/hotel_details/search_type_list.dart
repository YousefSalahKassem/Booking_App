import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchTypeListView extends StatefulWidget {
  const SearchTypeListView({Key? key}) : super(key: key);

  @override
  _SearchTypeListViewState createState() => _SearchTypeListViewState();
}

class _SearchTypeListViewState extends State<SearchTypeListView> with TickerProviderStateMixin {
  List<HotelListData> hotelTypeList = HotelListData.hotelTypeList;

  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, right: 16, left: 16),
        itemCount: hotelTypeList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var count = hotelTypeList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(50 * (1.0 - animation.value), 0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8, top: 0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Theme.of(context).dividerColor,
                                    blurRadius: 8,
                                    offset: const Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    hotelTypeList[index].imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                                highlightColor: Colors.transparent,
                                splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
                                onTap: () {
                                  setState(() {
                                    hotelTypeList[index].isSelected =
                                        !hotelTypeList[index].isSelected;
                                  });
                                },
                                child: Opacity(
                                  opacity: hotelTypeList[index].isSelected ? 1.0 : 0.0,
                                  child: CommonCard(
                                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                                    radius: 48,
                                    child: const SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.check,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            hotelTypeList[index].titleTxt,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
