import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/features/booking/presentation/screens/all_my_booking_screen.dart';
import 'package:bookingapp/src/features/profile/presentation/pages/profile_page.dart';
import 'package:bookingapp/src/features/search_explore/presentation/pages/explore/home_explore_screen.dart';
import 'package:bookingapp/src/features/search_explore/presentation/widget/bottom_tap_ui/tab_button_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({Key? key}) : super(key: key);

  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.explore;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = HomeExploreScreen(
        animationController: _animationController,
      );
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
          height: 60 + MediaQuery.of(context).padding.bottom, child: getBottomBarUI(bottomBarType)),
      body: _isFirstTime
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : _indexView,
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        if (tabType == BottomBarType.explore) {
          setState(() {
            _indexView = HomeExploreScreen(
              animationController: _animationController,
            );
          });
        } else if (tabType == BottomBarType.myBooking) {
          setState(() {
            _indexView = const AllMyBooking(
                // TODO change uncomment
                // animationController: _animationController,
                );
          });
        } else if (tabType == BottomBarType.profile) {
          setState(() {
            _indexView = const ProfilePage();
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return CommonCard(
      radius: 0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TabButtonUI(
                icon: Icons.search,
                isSelected: tabType == BottomBarType.explore,
                text: "explore",
                onTap: () {
                  tabClick(BottomBarType.explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.heart,
                isSelected: tabType == BottomBarType.myBooking,
                text: "My Booking",
                onTap: () {
                  tabClick(BottomBarType.myBooking);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.user,
                isSelected: tabType == BottomBarType.profile,
                text: "profile",
                onTap: () {
                  tabClick(BottomBarType.profile);
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

enum BottomBarType { explore, myBooking, profile }
