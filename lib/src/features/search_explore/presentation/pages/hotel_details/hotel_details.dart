import 'dart:ui';

import 'package:bookingapp/src/core/shareable_components/common_button.dart';
import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:bookingapp/src/core/utils/helper.dart';
import 'package:bookingapp/src/core/utils/media_query_values.dart';
import 'package:bookingapp/src/core/utils/text_styles.dart';
import 'package:bookingapp/src/features/search_explore/data/model/create_book_model.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotel_list_data.dart';
import 'package:bookingapp/src/features/search_explore/domain/entities/hotels_entity.dart';
import 'package:bookingapp/src/features/search_explore/presentation/cubit/create_booking/booking_cubit.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/hotel_details/review_data_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'hotel_rooms_list.dart';
import 'rating_view.dart';

class HotelDetails extends StatefulWidget {
  final HotelsEntity hotelData;

  const HotelDetails({Key? key, required this.hotelData}) : super(key: key);

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  var hotelText1 =
      "Featuring a fitness center, Grand Royale Park Hotel is located in Sweden, 4.7 km from National Museum...";
  var hotelText2 =
      "Featuring a fitness center, Grand Royale Park Hotel is located in Sweden, 4.7 km from National Museum a fitness center, Grand Royale Park Hotel is located in Sweden, 4.7 km from National Museum a fitness center, Grand Royale Park Hotel is located in Sweden, 4.7 km from National Museum";
  bool isFav = false;
  bool isReadless = false;
  late AnimationController animationController;
  var imageHeight = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
    animationController.forward();
    scrollController.addListener(() {
      if (mounted) {
        if (scrollController.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 && scrollController.offset < imageHeight) {
          // we need around half scrolling values
          if (scrollController.offset < ((imageHeight / 1.2))) {
            _animationController.animateTo((scrollController.offset / imageHeight));
          } else {
            // we static set the just above half scrolling values "around == 0.22"
            _animationController.animateTo((imageHeight / 1.2) / imageHeight);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CommonCard(
            radius: 0,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHeight),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  // Hotel title and animation view
                  child: getHotelDetails(isInList: true),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Summary",
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !isReadless ? widget.hotelData.description : hotelText2,
                          style: TextStyles(context).getDescriptionStyle().copyWith(
                                fontSize: 14,
                              ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless ? " Read more" : " Read less",
                          style: TextStyles(context)
                              .getRegularStyle()
                              .copyWith(color: AppColors.primary, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  // overall rating view
                  child: RatingView(hotelData: HotelListData.hotelList[0]),
                ),
                _getPhotoReviewUi("room_photo", 'view_all', Icons.arrow_forward, () {}),
                // Hotel inside photo view
                const HotelRoomsList(),
                _getPhotoReviewUi("reviews", 'view_all', Icons.arrow_forward, () {}),

                // feedback&Review data view
                for (var i = 0; i < 2; i++)
                  ReviewsView(
                    reviewsList: HotelListData.reviewsList[i],
                    animation: animationController,
                    animationController: animationController,
                    callback: () {},
                  ),

                const SizedBox(
                  height: 16,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.asset(
                        ImageAssets.mapImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 34, right: 10),
                      child: CommonCard(
                        color: AppColors.primary,
                        radius: 36,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            FontAwesomeIcons.mapPin,
                            color: Theme.of(context).backgroundColor,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  child: CommonButton(
                    buttonText: "Book Now",
                    backgroundColor: AppColors.primary,
                    onTap: () {
                      BlocProvider.of<BookingCubit>(context).createBooking(
                          CreateBookingModel(hotelId: widget.hotelData.id.toString()));
                      Navigator.pop(context);
                    },
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),

          // background image and Hotel name and their details and more details animation view
          _backgroundImageUI(widget.hotelData),

          // Arrow back Ui
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: AppBar().preferredSize.height,
              child: Row(
                children: <Widget>[
                  _getAppBarUi(Icons.arrow_back, () {
                    if (scrollController.offset != 0.0) {
                      scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 480), curve: Curves.easeInOutQuad);
                    } else {
                      Navigator.pop(context);
                    }
                  }),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // like and unlike view
                  _getAppBarUi(isFav ? Icons.favorite : Icons.favorite_border, () {
                    setState(() {
                      isFav = !isFav;
                    });
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getAppBarUi(IconData icon, VoidCallback onTap) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Container(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPhotoReviewUi(String title, String view, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              // "Photos",
              style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      view,
                      //  'View all',
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 14,
                          ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 26,
                      child: Icon(
                        icon,
                        //Icons.arrow_forward,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _backgroundImageUI(HotelsEntity hotelData) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          var opacity = 1.0 -
              (_animationController.value >= ((imageHeight / 1.2) / imageHeight)
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: imageHeight * (1.0 - _animationController.value),
            child: Stack(
              children: <Widget>[
                IgnorePointer(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://api.mahmoudtaha.com/images/${hotelData.images[0].image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: opacity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                                      child: getHotelDetails(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 16, top: 16),
                                      child: CommonButton(
                                          buttonText: "Book Now",
                                          backgroundColor: AppColors.primary,
                                          onTap: () {
                                            BlocProvider.of<BookingCubit>(context).createBooking(
                                                CreateBookingModel(
                                                    hotelId: hotelData.id.toString()));
                                            Navigator.pop(context);
                                            // NavigationServices(context)
                                            //     .gotoRoomBookingScreen(
                                            //         widget.hotelData.titleTxt);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(Radius.circular(38)),
                                    onTap: () {
                                      try {
                                        scrollController.animateTo(
                                            MediaQuery.of(context).size.height -
                                                MediaQuery.of(context).size.height / 5,
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.fastOutSlowIn);
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, top: 4, bottom: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "View Details",
                                            style: TextStyles(context).getBoldStyle().copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getHotelDetails({bool isInList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.hotelData.name,
                textAlign: TextAlign.left,
                style: TextStyles(context).getBoldStyle().copyWith(
                      fontSize: 22,
                      color: isInList
                          ? Theme.of(context).disabledColor.withOpacity(0.5)
                          : Colors.white,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    FontAwesomeIcons.locationDot,
                    size: 12,
                    color: AppColors.primary,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: context.width30 * 12,
                    child: Text(
                      widget.hotelData.address,
                      style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 14,
                            color: isInList
                                ? Theme.of(context).disabledColor.withOpacity(0.5)
                                : Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
              isInList
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          Helper.ratingStar(),
                          Text(
                            " ${HotelListData.hotelList[0].reviews}",
                            style: TextStyles(context).getRegularStyle().copyWith(
                                  fontSize: 14,
                                  color: isInList
                                      ? Theme.of(context).disabledColor.withOpacity(0.5)
                                      : Colors.white,
                                ),
                          ),
                          Text(
                            "Reviews",
                            style: TextStyles(context).getRegularStyle().copyWith(
                                  fontSize: 14,
                                  color: isInList ? Theme.of(context).disabledColor : Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "\$${widget.hotelData.price}",
              textAlign: TextAlign.left,
              style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 22,
                    color: isInList ? Theme.of(context).textTheme.bodyText1!.color : Colors.white,
                  ),
            ),
            Text(
              "/per night",
              style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 14,
                    color: isInList ? Theme.of(context).disabledColor : Colors.white,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
