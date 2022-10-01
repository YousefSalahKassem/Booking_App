import 'package:bookingapp/src/features/search_explore/data/model/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/shareable_components/common_appbar_view.dart';
import '../../../../../core/shareable_components/common_card.dart';
import '../../../../../core/shareable_components/common_search_bar.dart';
import '../../../../../core/shareable_components/remove_focuse.dart';
import '../../../domain/entities/hotel_list_data.dart';
import '../../cubit/hotels/hotels_cubit.dart';
import '../../cubit/hotels/hotels_state.dart';
import '../../widget/explore/home_list_view_page.dart';
import '../../widget/hotel_details/search_type_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<HotelListData> lastsSearchesList = HotelListData.lastsSearchesList;

  late AnimationController animationController;
  final myController = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Search Hotel",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 16),
                    child: CommonCard(
                      radius: 36,
                      child: CommonSearchBar(
                        textEditingController: myController,
                        iconData: FontAwesomeIcons.magnifyingGlass,
                        onChanged: (value){
                          setState(() {
                            BlocProvider.of<HotelsCubit>(context).getFilters(FilterModel(name: value));
                          });
                        },
                        enabled: true,
                        text: "Where are you going?",
                      ),
                    ),
                  ),
                  const SearchTypeListView(),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            "Last searches",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {
                              setState(() {
                                myController.text = '';
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Clear all",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  getDealListView(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDealListView() {
    return BlocBuilder<HotelsCubit, HotelsState>(builder: (context, state) {
      if (state is HotelsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HotelsComplete) {
        List<Widget> list = [];
        for (var i in state.hotels) {
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          list.add(
            HotelListViewPage(
              callback: () {},
              hotelData: i,
              animation: animation,
              animationController: animationController,
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
      return const SizedBox();
    });
  }
}
