import 'dart:convert';

class UserResponseDto {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;

  UserResponseDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  UserResponseDto copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? acessToken,
    String? refreshToken,
  }) {
    return UserResponseDto(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
    };
  }

  factory UserResponseDto.fromMap(Map<String, dynamic> map) {
    return UserResponseDto(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseDto.fromJson(String source) =>
      UserResponseDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponseDto(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, gender: $gender, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserResponseDto &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        image.hashCode;
  }
}


// {
//   "id": 1,
//   "username": "emilys",
//   "email": "emily.johnson@x.dummyjson.com",
//   "firstName": "Emily",
//   "lastName": "Johnson",
//   "gender": "female",
//   "image": "https://dummyjson.com/icon/emilys/128",
// }