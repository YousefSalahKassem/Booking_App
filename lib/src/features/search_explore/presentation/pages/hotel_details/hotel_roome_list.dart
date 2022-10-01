import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/shareable_components/common_card.dart';


class HotelRoomeList extends StatefulWidget {
  const HotelRoomeList({super.key});

  @override
  _HotelRoomeListState createState() => _HotelRoomeListState();
}

class _HotelRoomeListState extends State<HotelRoomeList> {
  List<String> photosList = [
    ImageAssets.hotel_room_1,
    ImageAssets.hotel_room_2,
    ImageAssets.hotel_room_3,
    ImageAssets.hotel_room_4,
    ImageAssets.hotel_room_5,
    ImageAssets.hotel_room_6,
    ImageAssets.hotel_room_7,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: photosList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonCard(
              radius: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    photosList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
