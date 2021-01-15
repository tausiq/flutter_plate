import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plate/user/app_user.dart';
import 'package:flutter_plate/user/app_user_entity.dart';
import 'package:flutter_plate/user/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CollectionReference _usercollection;

  /// If FirebaseAuth and/or GoogleSignIn are not injected into the UserRepository,
  /// then we instantiate them internally. This allows us to be able to inject
  /// mock instances so that we can easily test the UserRepository
  FirebaseUserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
        _usercollection = FirebaseFirestore.instance.collection('users');

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

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp(
      {String email, String firstName, String lastName, String password}) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _usercollection.doc(result.user.uid).set(AppUser(
            email: result.user.email,
            roles: {'user': true},
            id: result.user.uid,
            firstName: firstName,
            lastName: lastName)
        .toEntity()
        .toDocument());
    return result;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  /// getUser is only returning the current user's email address for the sake
  /// of simplicity but we can define our own User model and populate it with
  /// a lot more information about the user in more complex applications.
  Future<AppUser> getUser() async {
    return AppUser.fromEntity(AppUserEntity.fromSnapshot(
        await _usercollection.doc((_firebaseAuth.currentUser).uid).get()));
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser).uid;
  }

  Future<void> authenticateAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  @override
  Future<void> updateUser(AppUser item) {
    return _usercollection.doc(item.id).update(item.toEntity().toDocument());
  }

  @override
  Stream<List<AppUser>> users() {
    return _usercollection.snapshots().map((item) {
      return item.docs
          .map((doc) => AppUser.fromEntity(AppUserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<AppUser> getUserById(String id) async {
    return AppUser.fromEntity(
        AppUserEntity.fromSnapshot(await _usercollection.doc(id).get()));
  }

  @override
  Future<void> addNewUser(AppUser item, String password) {
    return signUp(
        firstName: item.firstName,
        lastName: item.lastName,
        email: item.email,
        password: password);
  }

  @override
  Future<void> deleteUser(AppUser item) async {
    return await _usercollection.doc(item.id).delete();
  }
}
