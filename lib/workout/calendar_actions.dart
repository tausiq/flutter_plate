
import 'package:flutter/material.dart';
import 'package:flutter_plate/widgets/date_time_picker.dart';
import 'package:flutter_plate/workout/bloc/bloc.dart';

class CalendarActions extends StatefulWidget {
  final WorkoutBloc _bloc;

  CalendarActions(this._bloc);

  @override
  _FilterActionsState createState() => _FilterActionsState();
}

class _FilterActionsState extends State<CalendarActions> {
  static DateTime now = DateTime.now();
  DateTime dateTime = DateTime(now.year, now.month, now.day);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: new Text('Meals of the day'),
        content: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DatePicker(
                labelText: 'Select Date',
                selectedDate: dateTime,
                selectDate: (dt) {
                  setState(() {
                    dateTime = dt;
                  });
                },
              ),
              FlatButton(
                  onPressed: () {
                    widget._bloc.add(LoadFilteredWorkouts(
                        dateTime,
                        dateTime,
                        TimeOfDay(hour: 0, minute: 0),
                        TimeOfDay(hour: 23, minute: 59)));
                    Navigator.of(context).pop();
                  },
                  child: Text('Done'))
            ],
          ),
        ));
  }
}
