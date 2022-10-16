import 'package:bookingapp/src/core/shareable_components/common_button.dart';
import 'package:bookingapp/src/core/shareable_components/common_card.dart';
import 'package:bookingapp/src/core/shareable_components/remove_focus.dart';
import 'package:bookingapp/src/core/utils/text_styles.dart';
import 'package:bookingapp/src/features/search_explore/presentation/widget/hotel_booking/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPopupView extends StatefulWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;

  const CalendarPopupView({
    Key? key,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onApplyClick,
    required this.onCancelClick,
    this.barrierDismissible = true,
    required this.minimumDate,
    required this.maximumDate,
  }) : super(key: key);

  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView> with TickerProviderStateMixin {
  late AnimationController animationController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    animationController.forward();
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
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: animationController.value,
            child: RemoveFocus(
              onClick: () {
                if (widget.barrierDismissible) Navigator.pop(context);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CommonCard(
                    radius: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _getFromToUi(
                              "from",
                              startDate != null
                                  ? DateFormat(
                                      "EEE, dd MMM",
                                    ).format(startDate!)
                                  : "--/-- ",
                            ),
                            Container(
                              height: 74,
                              width: 1,
                              color: Theme.of(context).dividerColor,
                            ),
                            _getFromToUi(
                              "to",
                              endDate != null
                                  ? DateFormat(
                                      "EEE, dd MMM",
                                    ).format(endDate!)
                                  : "--/-- ",
                            ),
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        CustomCalendarView(
                          minimumDate: widget.minimumDate,
                          maximumDate: widget.maximumDate,
                          initialEndDate: widget.initialEndDate,
                          initialStartDate: widget.initialStartDate,
                          startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                            setState(() {
                              startDate = startDateData;
                              endDate = endDateData;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                          child: CommonButton(
                            buttonText: "Apply",
                            onTap: () {
                              try {
                                widget.onApplyClick(startDate!, endDate!);
                                Navigator.pop(context);
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getFromToUi(String title, String subtext) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyles(context).getDescriptionStyle().copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            subtext,
            style: TextStyles(context).getBoldStyle().copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
