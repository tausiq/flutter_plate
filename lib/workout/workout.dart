import 'package:meta/meta.dart';

import 'workout_entity.dart';

@immutable
class Workout {
  final DateTime dateTime;
  final String id;
  final int calory;
  final String title;
  final String userId;

  Workout(this.title, this.dateTime, this.userId, {int calory = 500, String id})
      : this.id = id,
        this.calory = calory;

  Workout copyWith(
      {DateTime dateTime, String id, String userId, int calory, String title}) {
    return Workout(
      title ?? this.title,
      dateTime ?? this.dateTime,
      userId ?? this.userId,
      calory: calory ?? this.calory,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Workout &&
              runtimeType == other.runtimeType &&
              dateTime == other.dateTime &&
              id == other.id &&
              calory == other.calory &&
              title == other.title &&
              userId == other.userId;

  @override
  int get hashCode =>
      dateTime.hashCode ^
      id.hashCode ^
      calory.hashCode ^
      title.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'Workout{dateTime: $dateTime, id: $id, calory: $calory, title: $title, userId: $userId}';
  }

  WorkoutEntity toEntity() {
    return WorkoutEntity(dateTime, id, userId, title, calory);
  }

  static Workout fromEntity(WorkoutEntity entity) {
    return Workout(entity.title, entity.dateTime ?? DateTime.now(), entity.userId,
        calory: entity.calory, id: entity.id);
  }
}
