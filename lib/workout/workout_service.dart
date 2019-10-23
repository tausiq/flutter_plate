import 'package:flutter_plate/app/model/api/user.dart';
import 'package:flutter_plate/workout/workout.dart';

class WorkoutService {
  Workout workout;
  User user;

  WorkoutService(this.user, {this.workout});

  bool matchingRoles(List<String> allowedRoles) {
    for (int i = 0; i < allowedRoles.length; i++)
      return user.roles.containsKey(allowedRoles[i]) &&
          user.roles[allowedRoles[i]];
    return false;
  }

  bool canDelete() {
    if (workout.userId == user.id) return true;
    var allowedRoles = ['admin'];
    return matchingRoles(allowedRoles);
  }

  bool canEdit() {
    if (workout.userId == user.id) return true;
    var allowedRoles = ['admin'];
    return matchingRoles(allowedRoles);
  }

  bool canRead() {
    if (workout.userId == user.id) return true;
    var allowedRoles = ['admin'];
    return matchingRoles(allowedRoles);
  }
}
