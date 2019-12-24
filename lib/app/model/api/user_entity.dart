import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Models will contain plain dart classes which we will work with in our
/// Flutter Application. Having the separation between models and entities
/// allows us to switch our data provider at any time and only have to change
/// the the toEntity and fromEntity conversion in our model layer.
class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final Map<String, dynamic> roles;
  final String email;
  final String id;

  UserEntity(this.id, this.email, this.firstName, this.lastName, this.roles);

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

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json['id'] as String,
      json['email'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['roles'] as Map,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.documentID,
      snap.data['email'],
      snap.data['firstName'],
      snap.data['lastName'],
      new Map<String, dynamic>.from(snap.data['roles']),
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
  // TODO: implement props
  List<Object> get props => [firstName, lastName, roles, email, id];
}
