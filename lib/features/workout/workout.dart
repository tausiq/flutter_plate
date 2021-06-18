import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'workout_entity.dart';

@immutable
class Workout {
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  final String id;
  final int minutes;
  final String title;
  final String userId;

  Workout(this.title, this.dateTime, this.timeOfDay, this.userId, {int minutes = 30, String id})
      : this.id = id,
        this.minutes = minutes;

  Workout copyWith(
      {DateTime dateTime, TimeOfDay timeOfDay, String id, String userId, int calory, String title}) {
    return Workout(
      title ?? this.title,
      dateTime ?? this.dateTime,
      timeOfDay ?? this.timeOfDay,
      userId ?? this.userId,
      minutes: calory ?? this.minutes,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Workout &&
              runtimeType == other.runtimeType &&
              dateTime == other.dateTime &&
              timeOfDay == other.timeOfDay && 
              id == other.id &&
              minutes == other.minutes &&
              title == other.title &&
              userId == other.userId;

  @override
  int get hashCode =>
      dateTime.hashCode ^
      timeOfDay.hashCode ^ 
      id.hashCode ^
      minutes.hashCode ^
      title.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'Workout{dateTime: $dateTime, timeOfDay: $timeOfDay, id: $id, calory: $minutes, title: $title, userId: $userId}';
  }

  WorkoutEntity toEntity() {
    return WorkoutEntity(dateTime, timeOfDay, id, userId, title, minutes);
  }

  static Workout fromEntity(WorkoutEntity entity) {
    return Workout(entity.title, entity.dateTime ?? DateTime.now(), entity.timeOfDay ?? TimeOfDay.now(), entity.userId,
        minutes: entity.minutes, id: entity.id);
  }
}
