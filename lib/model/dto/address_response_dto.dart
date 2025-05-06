import 'dart:convert';

class AddressResponseDto {
  final String country;
  AddressResponseDto({
    required this.country,
  });

  AddressResponseDto copyWith({
    String? country,
  }) {
    return AddressResponseDto(
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
    };
  }

  factory AddressResponseDto.fromMap(Map<String, dynamic> map) {
    return AddressResponseDto(
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressResponseDto.fromJson(String source) => AddressResponseDto.fromMap(json.decode(source));

  @override
  String toString() => 'AddressResponseDto(country: $country)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddressResponseDto &&
      other.country == country;
  }

  @override
  int get hashCode => country.hashCode;
}
