import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SliderView extends StatefulWidget {
  final Function(double) onChangeDistValue;
  final double distValue;

  const SliderView({Key? key, required this.onChangeDistValue, required this.distValue})
      : super(key: key);

  @override
  _SliderViewState createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  double distValue = 50.0;

  @override
  void initState() {
    distValue = widget.distValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: distValue.round(),
              child: const SizedBox(),
            ),
            SizedBox(
              width: 170,
              child: Row(
                children: [
                  const Text(
                    "Less than",
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      (distValue / 10).toStringAsFixed(1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text(
                    "Km",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 100 - distValue.round(),
              child: const SizedBox(),
            ),
          ],
        ),
        Slider(
          onChanged: (value) {
            setState(() {
              distValue = value;
            });
            try {
              widget.onChangeDistValue(distValue);
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          min: 0.0,
          max: 100.0,
          activeColor: AppColors.primary,
          inactiveColor: Colors.grey.withOpacity(0.4),
          //   divisions: 100,
          value: distValue,
        ),
      ],
    );
  }
}
