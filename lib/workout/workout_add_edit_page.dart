
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/util/log/Log.dart';
import 'package:flutter_plate/util/util.dart';
import 'package:flutter_plate/widgets/date_time_picker.dart';
import 'package:flutter_plate/workout/bloc/bloc.dart';
import 'package:flutter_plate/workout/workout.dart';
import 'package:flutter_plate/workout/bloc/workout_add_edit_bloc.dart';
import 'package:flutter_plate/workout/bloc/workouts_state.dart';

import 'firebase_workout_repository.dart';
import 'bloc/workouts_event.dart';

class WorkoutAddEditPage extends StatefulWidget {
  static const String PATH = '/addeditworkout';

  final bool isEditing;
  final String workoutId;
  final String userId;

  WorkoutAddEditPage({
    Key key,
    @required this.isEditing,
    this.workoutId,
    this.userId
  }) : super(key: key);

  static String generatePath(bool isEditing, {String workoutId, String userId}) {
    Map<String, dynamic> param = {
      'isEditing': isEditing.toString(),
      'workoutId': workoutId,
      'userId': userId,
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
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String _title;
  String _calory;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();

  bool get isEditing => widget.isEditing;

  WorkoutAddEditBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = WorkoutAddEditBloc(workoutsRepository: FirebaseWorkoutsRepository(), workoutId: widget.workoutId)..add(LoadWorkout());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    _bloc = WorkoutAddEditBloc(
        workoutsRepository: FirebaseWorkoutsRepository(), workoutId: widget.workoutId)
      ..add(LoadWorkout());

    return BlocBuilder<WorkoutAddEditBloc, WorkoutAddEditState>(
        bloc: _bloc,
        builder: (context, state) {
          final workout = state is WorkoutLoaded ? state.item : null;
          if (state is WorkoutLoaded) {
            _titleController.text = isEditing ? workout?.title : '';
            _minutesController.text = isEditing ? workout?.minutes.toString() : '';
            _dateTime = isEditing ? workout?.dateTime : DateTime.now();
            _timeOfDay = isEditing ? workout?.timeOfDay : TimeOfDay.now();
          } else if (state is FormValueChanged) {
            _dateTime = state.dateTime;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isEditing ? 'Edit Workout' : 'Add Workout',
              ),
              actions: isEditing
                  ? [
                IconButton(
                  tooltip: 'Delete Workout',
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    if ((state as WorkoutLoaded).canDelete) {
                      _bloc.add(DeleteWorkout(workout));
                      Navigator.pop(context, workout);
                    } else {
                      Log.w("no permission for delete");
                    }
                  },
                )
              ]
                  : [],

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
                      selectedTime: _timeOfDay,
                      selectDate: (DateTime dt) {
                        _dateTime = DateTime(dt.year, dt.month, dt.day,
                            _dateTime.hour, _dateTime.minute);
                        _bloc.add(DateTimeChanged(_dateTime, _timeOfDay));
                      },
                      selectTime: (TimeOfDay td) {
                        _dateTime = DateTime(_dateTime.year, _dateTime.month,
                            _dateTime.day, td.hour, td.minute);
                        _bloc.add(DateTimeChanged(_dateTime, _timeOfDay));
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
                        hintText: 'Work minutes',
                      ),
                      onSaved: (value) => _calory = value,
                      controller: _minutesController,
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: isEditing ? 'Save changes' : 'Add Workout',
              child: Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  if (widget.isEditing) {
                    _bloc
                      ..add(
                        UpdateWorkout(
                          workout.copyWith(
                              dateTime: _dateTime,
                              timeOfDay: _timeOfDay,
                              calory: int.tryParse(_calory),
                              title: _title),
                        ),
                      );
                  } else {
                    _bloc.add(
                      AddWorkout(Workout(_title, _dateTime, _timeOfDay, Util.isNullOrEmpty(widget.userId) ?

                          AppProvider.getApplication(context).loggedInUser.id : widget.userId,
                          minutes: int.tryParse(_calory))),
                    );
                  }
                  Navigator.pop(context);
                }
              },
            ),
          );
        });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
