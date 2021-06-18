import 'package:flutter_plate/features/user/app_user.dart';
import 'package:flutter_plate/features/workout/workout.dart';

class WorkoutService {
  Workout workout;
  AppUser user;

  WorkoutService(this.user, {this.workout});

  bool matchingRoles(List<String> allowedRoles) {
    for (int i = 0; i < allowedRoles.length; i++)
      return user.roles.containsKey(allowedRoles[i]) && user.roles[allowedRoles[i]];
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
