import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RangeSliderView extends StatefulWidget {
  final Function(RangeValues) onChangeRangeValues;
  final RangeValues values;

  const RangeSliderView({Key? key, required this.values, required this.onChangeRangeValues})
      : super(key: key);

  @override
  _RangeSliderViewState createState() => _RangeSliderViewState();
}

class _RangeSliderViewState extends State<RangeSliderView> {
  late RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: _values.start.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    "\$${_values.start.round()}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 5000 - _values.start.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: _values.end.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    "\$${_values.end.round()}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 5000 - _values.end.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
              //   rangeThumbShape: CustomRangeThumbShape(),
              ),
          child: RangeSlider(
            values: _values,
            min: 10.0,
            max: 5000.0,
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey.withOpacity(0.4),
            divisions: 1000,
            onChanged: (RangeValues values) {
              try {
                setState(() {
                  _values = values;
                });
                widget.onChangeRangeValues(_values);
              } catch (e) {}
            },
          ),
        ),
      ],
    );
  }
}
