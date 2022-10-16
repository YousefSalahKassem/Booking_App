import 'package:bookingapp/src/config/routes/app_routes.dart';
import 'package:bookingapp/src/config/themes/app_themes.dart';
import 'package:bookingapp/src/core/shareable_components/bottom_top_move_animation_view.dart';
import 'package:bookingapp/src/core/shareable_components/common_button.dart';
import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/shareable_components/common_search_bar.dart';
import 'package:bookingapp/src/core/utils/text_styles.dart';
import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/hotels/hotels_cubit.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/hotel_details/hotel_details.dart';
import 'package:bookingapp/src/features/search_explore/presentation/widget/explore/home_explore_sliver_view.dart';
import 'package:bookingapp/src/features/search_explore/presentation/widget/explore/home_list_view_page.dart';
import 'package:bookingapp/src/features/search_explore/presentation/widget/explore/title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeExploreScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeExploreScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  State<HomeExploreScreen> createState() => _HomeExploreScreenState();
}

class _HomeExploreScreenState extends State<HomeExploreScreen> with TickerProviderStateMixin {
  late ScrollController controller;
  late AnimationController _animationController;
  var sliderImageHeight = 0.0;
  final myController = TextEditingController();

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);
    controller.addListener(() {
      if (mounted) {
        if (controller.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 && controller.offset < sliderImageHeight) {
          // we need around half scrolling values
          if (controller.offset < ((sliderImageHeight / 1.5))) {
            _animationController.animateTo((controller.offset / sliderImageHeight));
          } else {
            // we static set the just above half scrolling values "around == 0.64"
            _animationController.animateTo((sliderImageHeight / 1.5) / sliderImageHeight);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHeight = MediaQuery.of(context).size.width * 1.3;
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            itemCount: 1,
            padding: EdgeInsets.only(top: sliderImageHeight + 32, bottom: 16),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              // some list UI
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / 1) * index, 1.0, curve: Curves.fastOutSlowIn),
                ),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleView(
                    titleTxt: 'Best Deals',
                    subTxt: 'View all',
                    animation: animation,
                    isLeftButton: true,
                    animationController: widget.animationController,
                    click: () {},
                  ),
                  getDealListView(index)
                ],
              );
            },
          ),
          // sliderUI with 3 images are moving
          _sliderUI(),

          // viewHotels Button UI for click event
          _viewHotelsButton(_animationController),

          //just gradient for see the time and battery Icon on "TopBar"
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).backgroundColor.withOpacity(0.4),
                  Theme.of(context).backgroundColor.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
          ),
          //   searchUI on Top  Positioned
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: searchUI(),
          )
        ],
      ),
    );
  }

  Widget _viewHotelsButton(AnimationController animationController) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        var opacity = 1.0 - (animationController.value > 0.64 ? 1.0 : animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHeight * (1.0 - animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: 24,
                child: Opacity(
                  opacity: opacity,
                  child: CommonButton(
                    onTap: () {
                      if (opacity != 0) {
                        Navigator.pushNamed(context, Routes.hotelHomeScreenRoute);
                      }
                    },
                    backgroundColor: const Color(0xFF4FBE9F),
                    buttonTextWidget: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        'View Hotel',
                        style: TextStyles(context)
                            .getRegularStyle()
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          // we calculate the opacity between 0.64 to 1.0
          var opacity =
              1.0 - (_animationController.value > 0.64 ? 1.0 : _animationController.value);
          return SizedBox(
            height: sliderImageHeight * (1.0 - _animationController.value),
            child: HomeExploreSliderView(
              opValue: opacity,
              click: () {},
            ),
          );
        },
      ),
    );
  }

  Widget getDealListView(int index) {
    BlocProvider.of<HotelsCubit>(context).getFilters(FilterModel(name: myController.text));
    return BlocBuilder<HotelsCubit, HotelsState>(builder: (context, state) {
      if (state is HotelsComplete) {
        List<Widget> list = [];
        for (var i in state.hotels) {
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: widget.animationController,
              curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          list.add(
            HotelListViewPage(
              callback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HotelDetails(
                              hotelData: i,
                            )));
              },
              hotelData: i,
              animation: animation,
              animationController: widget.animationController,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: list,
          ),
        );
      }
      return Container();
    });
  }

  Widget searchUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: CommonCard(
        radius: 36,
        child: CommonSearchBar(
          textEditingController: myController,
          iconData: FontAwesomeIcons.magnifyingGlass,
          onChanged: (String txt) {
            BlocProvider.of<HotelsCubit>(context).getFilters(FilterModel(name: txt));
          },
          enabled: true,
          text: "Where are you going?",
        ),
      ),
    );
  }
}
