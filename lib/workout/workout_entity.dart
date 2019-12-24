import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Models will contain plain dart classes which we will work with in our
/// Flutter Application. Having the separation between models and entities
/// allows us to switch our data provider at any time and only have to change
/// the the toEntity and fromEntity conversion in our model layer.
class WorkoutEntity extends Equatable {
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  final String id;
  final int minutes;
  final String title;
  final String userId;

  WorkoutEntity(this.dateTime, this.timeOfDay, this.id, this.userId, this.title, this.minutes);

  Map<String, Object> toJson() {
    return {
      'dateTime': dateTime,
      'timeOfDay': timeOfDay,
      'title': title,
      'calory': minutes,
      'id': id,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'WorkoutEntity{dateTime: $dateTime, timeOfDay: $timeOfDay, id: $id, calory: $minutes, title: $title, userId: $userId}';
  }

  static WorkoutEntity fromJson(Map<String, Object> json) {
    return WorkoutEntity(
      json['dateTime'] as DateTime,
      json['timeOfDay'] as TimeOfDay,
      json['id'] as String,
      json['userId'] as String,
      json['title'] as String,
      json['calory'] as int,
    );
  }

  static WorkoutEntity fromSnapshot(DocumentSnapshot snap) {
    return WorkoutEntity(
      DateTime.fromMillisecondsSinceEpoch(snap.data['dateTime']),
            TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(snap.data['dateTime'] + snap.data['timeOfDay'])),
      snap.documentID,
      snap.data['userId'],
      snap.data['title'],
      snap.data['calory'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'dateTime': dateTime.toUtc().millisecondsSinceEpoch,
            'timeOfDay': DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute).toUtc().millisecondsSinceEpoch - dateTime.toUtc().millisecondsSinceEpoch,
      'title': title,
      'calory': minutes,
      'userId': userId,
    };
  }

  @override
  List<Object> get props => [dateTime, timeOfDay, id, minutes, title, userId];
}
