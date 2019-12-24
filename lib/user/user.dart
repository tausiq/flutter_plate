import 'user_entity.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImageURL;
  final String email;
  final String phone;
  final Map<String, dynamic> roles;

  User(
      {String id,
        String firstName,
      String lastName,
      String profileImageURL,
      String email,
      String phone,
      Map<String, dynamic> roles})
      : this.id = id,
        this.firstName = firstName ?? '',
        this.lastName = lastName ?? '',
        this.profileImageURL = profileImageURL,
        this.email = email ?? '',
        this.phone = phone ?? '',
        this.roles = roles ?? Map();

  User copyWith(
      {String id,
        String firstName,
        String lastName,
        String profileImageURL,
        String email,
        String phone,
        Map<String, dynamic> roles}) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImageURL: profileImageURL ?? this.profileImageURL,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      roles: roles ?? this.roles,
    );
  }


  User.fromMap(Map<dynamic, dynamic> val)
      : id = val['id'],
        firstName = val['first_name'],
        lastName = val['last_name'],
        email = val['email'],
        phone = val['phone'],
        profileImageURL = val['profile_image_url'],
        roles = val['roles'];

  toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'profile_image_url': profileImageURL,
      'roles': roles,
    };
  }

  UserEntity toEntity() {
    return UserEntity(id, email, firstName, lastName, roles);
  }

  static User fromEntity(UserEntity entity) {
    return User(id: entity.id, firstName: entity.firstName, lastName: entity.lastName, email: entity.email, roles: entity.roles);
  }

  bool isAdmin() {
    return roles.containsKey('admin');
  }

  bool isManager() {
    return roles.containsKey('manager');
  }

}
