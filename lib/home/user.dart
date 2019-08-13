class User {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImageURL;
  final String email;
  final String phone;

  User.fromMap(Map<dynamic, dynamic> val)
      : id = val['id'],
        firstName = val['first_name'],
        lastName = val['last_name'],
        email = val['email'],
        phone = val['phone'],
        profileImageURL = val['profile_image_url'];

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
