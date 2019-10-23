
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/widgets/date_time_picker.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:flutter_plate/workout/workout_add_edit_bloc.dart';
import 'package:flutter_plate/workout/workouts_state.dart';

import 'firebase_workout_repository.dart';
import 'workouts_event.dart';

class WorkoutAddEditPage extends StatefulWidget {
  static const String PATH = '/addeditworkout';

  final bool isEditing;
  final String workoutId;

  WorkoutAddEditPage({
    Key key,
    @required this.isEditing,
    this.workoutId,
  }) : super(key: key);

  static String generatePath(bool isEditing, {String workoutId}) {
    Map<String, dynamic> param = {
      'isEditing': isEditing.toString(),
      'workoutId': workoutId,
    };
    Uri uri = Uri(path: PATH, queryParameters: param);
    return uri.toString();
  }

  @override
  _WorkoutAddEditPageState createState() => _WorkoutAddEditPageState();
}

class _WorkoutAddEditPageState extends State<WorkoutAddEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();
  String _title;
  String _calory;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _caloryController = TextEditingController();

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _bloc = WorkoutsAddEditBloc(
        workoutsRepository: FirebaseWorkoutsRepository(), workoutId: widget.workoutId)
      ..dispatch(LoadWorkout());

    return BlocBuilder<WorkoutsAddEditBloc, WorkoutsState>(
        bloc: _bloc,
        builder: (context, state) {
          final workout = state is WorkoutLoaded ? state.item : null;
          if (state is WorkoutLoaded) {
            _titleController.text = isEditing ? workout?.title : '';
            _caloryController.text = isEditing ? workout?.calory : '';
            _dateTime = isEditing ? workout.dateTime : DateTime.now();
          } else if (state is FormValueChanged) {
            _dateTime = state.dateTime;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isEditing ? 'Edit Workout' : 'Add Workout',
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DateTimePicker(
                      key: ValueKey('date_today'),
                      labelText: 'Date',
                      selectedDate: _dateTime,
                      selectedTime: TimeOfDay(
                          hour: _dateTime.hour, minute: _dateTime.minute),
                      selectDate: (DateTime dt) {
                        _dateTime = DateTime(dt.year, dt.month, dt.day,
                            _dateTime.hour, _dateTime.minute);
                        _bloc.dispatch(DateTimeChanged(_dateTime));
                      },
                      selectTime: (TimeOfDay td) {
                        _dateTime = DateTime(_dateTime.year, _dateTime.month,
                            _dateTime.day, td.hour, td.minute);
                        _bloc.dispatch(DateTimeChanged(_dateTime));
                      },
                    ),
                    TextFormField(
                      autofocus: !isEditing,
                      style: textTheme.headline,
                      decoration: InputDecoration(
                        hintText: 'Workout name',
                      ),
                      validator: (val) {
                        return val.trim().isEmpty
                            ? 'Please enter workout name'
                            : null;
                      },
                      onSaved: (value) => _title = value,
                      controller: _titleController,
                    ),
                    TextFormField(
                      style: textTheme.subhead,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Calory',
                      ),
                      onSaved: (value) => _calory = value,
                      controller: _caloryController,
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: isEditing ? 'Save changes' : 'Add Workout',
              child: Icon(isEditing ? Icons.check : Icons.add),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  if (widget.isEditing) {
                    _bloc
                      ..dispatch(
                        UpdateWorkout(
                          workout.copyWith(
                              dateTime: _dateTime,
                              calory: int.tryParse(_calory),
                              title: _title),
                        ),
                      );
                  } else {
                    _bloc.dispatch(
                      AddWorkout(Workout(_title, _dateTime,
                          AppProvider.getApplication(context).loggedInUser.id,
                          calory: int.tryParse(_calory))),
                    );
                  }
                  Navigator.pop(context);
                }
              },
            ),
          );
        });
  }
}
