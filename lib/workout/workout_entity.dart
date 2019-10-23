import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Models will contain plain dart classes which we will work with in our
/// Flutter Application. Having the separation between models and entities
/// allows us to switch our data provider at any time and only have to change
/// the the toEntity and fromEntity conversion in our model layer.
class WorkoutEntity extends Equatable {
  final DateTime dateTime;
  final String id;
  final int calory;
  final String title;
  final String userId;

  WorkoutEntity(this.dateTime, this.id, this.userId, this.title, this.calory);

  Map<String, Object> toJson() {
    return {
      'dateTime': dateTime,
      'title': title,
      'calory': calory,
      'id': id,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'WorkoutEntity{dateTime: $dateTime, id: $id, calory: $calory, title: $title, userId: $userId}';
  }

  static WorkoutEntity fromJson(Map<String, Object> json) {
    return WorkoutEntity(
      json['dateTime'] as DateTime,
      json['id'] as String,
      json['userId'] as String,
      json['title'] as String,
      json['calory'] as int,
    );
  }

  static WorkoutEntity fromSnapshot(DocumentSnapshot snap) {
    return WorkoutEntity(
      snap.data['dateTime'],
      snap.documentID,
      snap.data['userId'],
      snap.data['title'],
      snap.data['calory'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'dateTime': dateTime,
      'title': title,
      'calory': calory,
      'userId': userId,
    };
  }
}
