import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/utils/asset_manager.dart';
import 'package:flutter/material.dart';

class HotelRoomsList extends StatefulWidget {
  const HotelRoomsList({super.key});

  @override
  _HotelRoomsListState createState() => _HotelRoomsListState();
}

class _HotelRoomsListState extends State<HotelRoomsList> {
  List<String> photosList = [
    ImageAssets.hotelRoom1,
    ImageAssets.hotelRoom2,
    ImageAssets.hotelRoom3,
    ImageAssets.hotelRoom4,
    ImageAssets.hotelRoom5,
    ImageAssets.hotelRoom6,
    ImageAssets.hotelRoom7,
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
