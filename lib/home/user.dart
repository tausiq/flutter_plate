import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImageURL;
  final String email;
  final String phone;
  final DocumentReference reference;

  User.fromMap(Map<dynamic, dynamic> val, {this.reference})
      : id = val['id'],
        firstName = val['first_name'],
        lastName = val['last_name'],
        email = val['email'],
        phone = val['phone'],
        profileImageURL = val['profile_image_url'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'profile_image_url': profileImageURL
    };
  }
}
