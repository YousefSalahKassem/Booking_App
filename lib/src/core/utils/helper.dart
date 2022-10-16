import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../features/search_explore/domain/entities/room_data.dart';
import '../shareable_components/custom_dialog.dart';

class Helper {
  static String getRoomText(RoomData roomData) {
    return "${roomData.numberRoom} ${"Room"} ${roomData.people} ${"People"}";
  }

  static String getDateText(DateText dateText) {
    return "0${dateText.startDate} ${DateFormat('MMM').format(DateTime.now())} - 0${dateText.endDate} ${DateFormat('MMM').format(DateTime.now().add(const Duration(days: 2)))}";
  }

  // static String getLastSearchDate(DateText dateText) {
  //   LanguageType _languageType = applicationContext == null
  //       ? LanguageType.en
  //       : applicationContext!.read<ThemeProvider>().languageType;
  //   return "${dateText.startDate} - ${dateText.endDate} ${DateFormat('MMM', _languageType.toString().split(".")[1]).format(DateTime.now().add(Duration(days: 2)))}";
  // }
  //
  static String getPeopleAndChildren(RoomData roomData) {
    return "${"sleeps"} ${roomData.numberRoom} ${"people"} + ${roomData.numberRoom} ${"children"} ";
  }

  static Widget ratingStar({double rating = 4.5}) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColors.primary,
      ),
      itemCount: 5,
      unratedColor: const Color(0xFFADADAD),
      itemSize: 18.0,
      direction: Axis.horizontal,
    );
  }

  Future<bool> showCommonPopup(String title, String descriptionText, BuildContext context,
      {bool isYesOrNoPopup = false, bool barrierDismissible = true}) async {
    bool isOkClick = false;
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: descriptionText,
        onCloseClick: () {
          Navigator.of(context).pop();
        },
        actionButtonList: isYesOrNoPopup
            ? <Widget>[
                CustomDialogActionButton(
                  buttonText: "NO",
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CustomDialogActionButton(
                  buttonText: "YES",
                  color: Colors.red,
                  onPressed: () {
                    isOkClick = true;
                    Navigator.of(context).pop();
                  },
                )
              ]
            : <Widget>[
                CustomDialogActionButton(
                  buttonText: "OK",
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
      ),
    ).then((_) {
      return isOkClick;
    });
  }
}
