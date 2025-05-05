import 'dart:convert';

class UserRequestDto {
  String username;
  String password;
  
  UserRequestDto({
    required this.username,
    required this.password,
  });

  UserRequestDto copyWith({
    String? username,
    String? password,
  }) {
    return UserRequestDto(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory UserRequestDto.fromMap(Map<String, dynamic> map) {
    return UserRequestDto(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequestDto.fromJson(String source) => UserRequestDto.fromMap(json.decode(source));

  @override
  String toString() => 'UserRequestDto(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserRequestDto &&
      other.username == username &&
      other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
