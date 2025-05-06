import 'dart:convert';
import 'package:trilhamobileatvd/model/dto/address_response_dto.dart';

class UserResponseDto {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  int age;
  String gender;
  String image;
  String accessToken;
  String refreshToken;
  final AddressResponseDto address;

  UserResponseDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
    required this.address,
  });
  

  UserResponseDto copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? image,
    String? accessToken,
    String? refreshToken,
    AddressResponseDto? address,
  }) {
    return UserResponseDto(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'address': address.toMap(),
    };
  }

  factory UserResponseDto.fromMap(Map<String, dynamic> map) {
    return UserResponseDto(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      address: map['address'] != null
            ? AddressResponseDto.fromMap(map['address'])
            : AddressResponseDto(
              country: ''
            )
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseDto.fromJson(String source) => UserResponseDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponseDto(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, age: $age, gender: $gender, image: $image, accessToken: $accessToken, refreshToken: $refreshToken, address: $address)';
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
      other.age == age &&
      other.gender == gender &&
      other.image == image &&
      other.accessToken == accessToken &&
      other.refreshToken == refreshToken &&
      other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      accessToken.hashCode ^
      refreshToken.hashCode ^
      address.hashCode;
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