import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Models will contain plain dart classes which we will work with in our
/// Flutter Application. Having the separation between models and entities
/// allows us to switch our data provider at any time and only have to change
/// the the toEntity and fromEntity conversion in our model layer.
class AppUserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final Map<String, dynamic> roles;
  final String email;
  final String id;

  AppUserEntity(this.id, this.email, this.firstName, this.lastName, this.roles);

  Map<String, Object> toJson() {
    return {
      'email': email,
      'roles': roles,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'UserEntity{firstName: $firstName, lastName: $lastName, roles: $roles, email: $email, id: $id}';
  }

  static AppUserEntity fromJson(Map<String, Object> json) {
    return AppUserEntity(
      json['id'] as String,
      json['email'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['roles'] as Map,
    );
  }

  static AppUserEntity fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data() ?? const {};

    return AppUserEntity(
      snap.id,
      data['email'] ?? '',
      data['firstName'] ?? '',
      data['lastName'] ?? '',
      // snap.data['firstName'] ?? '',
      // snap.data['lastName'] ?? '',
      new Map<String, dynamic>.from(data['roles'] ?? {}),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles,
    };
  }

  @override
  List<Object> get props => [firstName, lastName, roles, email, id];
}
