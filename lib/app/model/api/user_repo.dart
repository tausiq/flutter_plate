import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plate/app/model/api/user.dart';
import 'package:flutter_plate/app/model/api/user_entity.dart';
import 'package:flutter_plate/app/model/api/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class UserRepository implements IUserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final _usercollection;

  /// If FirebaseAuth and/or GoogleSignIn are not injected into the UserRepository,
  /// then we instantiate them internally. This allows us to be able to inject
  /// mock instances so that we can easily test the UserRepository
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
      _usercollection = Firestore.instance.collection('users');

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<AuthResult> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResult> signUp({String email, String password}) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _usercollection.add(User(email: result.user.email, roles: {'user': true}, id: result.user.uid).toEntity().toDocument());
    return result;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  /// getUser is only returning the current user's email address for the sake
  /// of simplicity but we can define our own User model and populate it with
  /// a lot more information about the user in more complex applications.
  Future<User> getUser() async {
    final QuerySnapshot result = await _usercollection
        .where("id", isEqualTo: (await _firebaseAuth.currentUser()).uid).getDocuments();
    return User.fromEntity(UserEntity.fromSnapshot(result.documents[0]));
//    return _usercollection.document((await _firebaseAuth.currentUser()).uid).get().then((user) {
//      return User.fromEntity(UserEntity.fromSnapshot(user));
//    });
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<void> authenticateAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }
}
