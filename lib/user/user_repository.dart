import 'dart:async';

abstract class IUserRepository {
  Future<bool> isSignedIn();

  Future<void> authenticate();

  Future<String> getUserId();
}
