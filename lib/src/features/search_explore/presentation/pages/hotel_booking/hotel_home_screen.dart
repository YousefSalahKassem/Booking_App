import 'package:bookingapp/src/features/search_explore/presentation/cubit/hotels/hotels_state.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/hotel_details/room_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/shareable_components/common_card.dart';
import '../../../../../core/shareable_components/common_search_bar.dart';
import '../../../../../core/shareable_components/remove_focuse.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../data/model/filter_model.dart';
import '../../cubit/hotels/hotels_cubit.dart';
import '../../widget/hotel_booking/filter_bar_UI.dart';
import '../../widget/hotel_booking/time_date_view.dart';
import '../myTrips/hotel_list_view.dart';

class HotelHomeScreen extends StatefulWidget {
  const HotelHomeScreen({super.key});

  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _animationController;
  ScrollController scrollController = ScrollController();
  int room = 1;
  int ad = 2;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  bool _isShowMap = false;

  final searchBarHieght = 158.0;
  final filterBarHieght = 52.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        _animationController.animateTo(0.0);
      } else if (scrollController.offset > 0.0 &&
          scrollController.offset < searchBarHieght) {
        // we need around searchBarHieght scrolling values in 0.0 to 1.0
        _animationController
            .animateTo((scrollController.offset / searchBarHieght));
      } else {
        _animationController.animateTo(1.0);
      }
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          RemoveFocuse(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                _getAppBarUI(),
                _isShowMap
                    ? const SizedBox()
                // MapAndListView(
                //   hotelList: hotelList,
                //   searchBarUI: _getSearchBarUI(),
                // )
                    : Expanded(
                  child: Stack(
                    children: <Widget>[
                      BlocBuilder<HotelsCubit,HotelsState>(builder: (context,state){
                        if(state is HotelsComplete){
                          final hotelList = state.hotels;
                          return ListView.builder(
                            controller: scrollController,
                            itemCount: state.hotels.length,
                            padding: const EdgeInsets.only(
                              top: 8 + 158 + 52.0,
                            ),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var count = hotelList.length > 10
                                  ? 10
                                  : hotelList.length;
                              var animation = Tween(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval(
                                      (1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return HotelListView(
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RoomBookingScreen(
                                        hotelName: hotelList[index].name,
                                      ),
                                    ),
                                  );
                                },
                                hotelData: hotelList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator(),);
                      }),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) {
                          return Positioned(
                            top: -searchBarHieght *
                                (_animationController.value),
                            left: 0,
                            right: 0,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  child: Column(
                                    children: <Widget>[
                                      //hotel search view
                                      _getSearchBarUI(),
                                      // time date and number of rooms view
                                      const TimeDateView(),
                                    ],
                                  ),
                                ),
                                //hotel price & facilitate  & distance
                                const FilterBarUI(),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.only(right: 8, top: 8, bottom: 8, left: 8),
              child: CommonCard(
                radius: 36,
                child:  CommonSearchBar(
                  enabled: true,
                  ishsow: false,
                  text: "London...",
                  onChanged: (String txt) {
                    BlocProvider.of<HotelsCubit>(context).getFilters(FilterModel(name: txt));
                  },
                ),
              ),
            ),
          ),
          CommonCard(
            radius: 36,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // NavigationServices(context).gotoSearchScreen();
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAppBarUI() {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Explore",
                style: TextStyles(context).getTitleStyle(),
              ),
            ),
          ),
          SizedBox(
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite_border),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      setState(() {
                        _isShowMap = !_isShowMap;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(_isShowMap
                          ? Icons.sort
                          : FontAwesomeIcons.mapLocationDot),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
