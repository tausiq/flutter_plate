import 'dart:async';

import 'package:flutter_plate/user/user.dart';

abstract class UserRepository {
  Future<bool> isSignedIn();
  Future<void> authenticate();
  Future<String> getUserId();
  Stream<List<User>> users();
  Future<void> updateUser(User item);
  Future<User> getUserById(String id);

}
