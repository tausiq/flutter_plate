import 'package:flutter/material.dart';
import 'package:flutter_plate/widgets/date_time_picker.dart';
import 'package:flutter_plate/workout/bloc/bloc.dart';


class FilterActions extends StatefulWidget {
  final WorkoutBloc workoutBloc;

  FilterActions(this.workoutBloc);

  @override
  _FilterActionsState createState() => _FilterActionsState();
}

class _FilterActionsState extends State<FilterActions> {

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
        title: new Text('Filter Meals'),
        content: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DatePicker(labelText: 'From Date', selectedDate: fromDate, selectDate: (dt) {
                setState(() {
                  fromDate = dt;
                });

              },),
              DatePicker(labelText: 'To Date', selectedDate: toDate, selectDate: (dt) {
                setState(() {
                  toDate = dt;
                });

              },),
              TimePicker(labelText: 'From Time', selectedTime: fromTime, selectTime: (ft) {
                setState(() {
                  fromTime = ft;
                });

              },),
              TimePicker(labelText: 'To Time', selectedTime: toTime, selectTime: (tt) {
                setState(() {
                  toTime = tt;
                });

              },),
              FlatButton(onPressed: (){
                widget.workoutBloc.add(LoadFilteredWorkouts(fromDate, toDate, fromTime, toTime));
                Navigator.of(context).pop();
              },
                  child: Text('Done'))
            ],
          ),));
  }

}
