import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plate/widgets/input_drop_down.dart';

class TimePicker extends StatelessWidget {
  const TimePicker(
      {Key key, this.labelText, this.selectedTime, this.selectTime})
      : super(key: key);

  final String labelText;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.headline4;
    return InputDropdown(
      labelText: labelText,
      valueText: selectedTime.format(context),
      valueStyle: valueStyle,
      onPressed: () {
        _selectTime(context);
      },
    );
  }
}
