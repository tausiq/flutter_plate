import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/time.dart';
import 'package:flutter_plate/workout/workout_repository.dart';
import 'package:preferences/preferences.dart';


import 'workout.dart';
import 'workout_entity.dart';

class FirebaseWorkoutsRepository implements WorkoutRepository {
  final workoutCollection = Firestore.instance.collection('workouts');

  @override
  Future<void> addNewWorkout(Workout item) {
    return workoutCollection.add(item.toEntity().toDocument());
  }

  @override
  Future<void> deleteWorkout(Workout item) async {
    return workoutCollection.document(item.id).delete();
  }

  @override
  Stream<List<Workout>> workouts() {
    return workoutCollection.where('userId', isEqualTo: PrefService.getString('user_id')).snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Workout.fromEntity(WorkoutEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateWorkout(Workout item) {
    return workoutCollection
        .document(item.id)
        .updateData(item.toEntity().toDocument());
  }

  @override
  Future<Workout> getWorkout(String id) {
    return workoutCollection.document(id).get().then((doc) {
      return Workout.fromEntity(WorkoutEntity.fromSnapshot(doc));
    });
  }

  @override
  Stream<List<Workout>> workoutsByUserId(String userId) {
    return workoutCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => Workout.fromEntity(WorkoutEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Stream<List<Workout>> filteredWorkouts(DateTime fromDate, DateTime toDate, TimeOfDay fromTime, TimeOfDay toTime) {
    int fTime = fromTime.hour * 60 * 60 * 1000 + fromTime.minute * 60 * 1000;
    int tTime = toTime.hour * 60 * 60 * 1000 + toTime.minute * 60 * 1000;
    return workoutCollection.where('dateTime', isGreaterThanOrEqualTo: fromDate.toUtc().millisecondsSinceEpoch)
    .where('dateTime', isLessThanOrEqualTo: toDate.toUtc().millisecondsSinceEpoch).snapshots().map((snapshot) {
return snapshot.documents
          .map((doc) => Workout.fromEntity(WorkoutEntity.fromSnapshot(doc))).where((doc) => doc.userId == PrefService.getString('user_id')).where((doc) => doc.timeOfDay.hour * 60 * 60 * 1000 + doc.timeOfDay.minute * 60 * 1000 >= fTime  && 
          doc.timeOfDay.hour * 60 * 60 * 1000 + doc.timeOfDay.minute * 60 * 1000 < tTime)
          .toList();


    });
  }
}
