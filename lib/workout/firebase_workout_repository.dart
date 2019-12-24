import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/time.dart';
import 'package:flutter_plate/workout/workout_repository.dart';


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
    return workoutCollection.snapshots().map((snapshot) {
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
    // TODO: implement filteredWorkouts
    return null;
  }
}
