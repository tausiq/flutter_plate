import 'dart:async';

import 'package:flutter_plate/features/user/app_user.dart';

abstract class UserRepository {
  Future<bool> isSignedIn();
  Future<void> authenticate();
  Future<String> getUserId();
  Stream<List<AppUser>> users();
  Future<void> updateUser(AppUser item);
  Future<AppUser> getUserById(String id);
  Future<void> addNewUser(AppUser item, String password);
  Future<void> deleteUser(AppUser item);
}
