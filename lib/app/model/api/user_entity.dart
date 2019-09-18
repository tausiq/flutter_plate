import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Models will contain plain dart classes which we will work with in our
/// Flutter Application. Having the separation between models and entities
/// allows us to switch our data provider at any time and only have to change
/// the the toEntity and fromEntity conversion in our model layer.
class UserEntity extends Equatable {
  final Map<String, dynamic> roles;
  final String email;
  final String id;

  UserEntity(this.id, this.email, this.roles);

  Map<String, Object> toJson() {
    return {
      'email': email,
      'roles': roles,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'UserEntity { id: $id, roles: $roles, email: $email }';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json['id'] as String,
      json['email'] as String,
      json['roles'] as Map,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.documentID,
      snap.data['email'],
      new Map<String, dynamic>.from(snap.data['roles']),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'email': email,
      'roles': roles,
    };
  }
}
