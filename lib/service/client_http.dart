import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:trilhamobileatvd/model/dto/user_request_dto.dart';
import 'package:trilhamobileatvd/model/dto/user_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:trilhamobileatvd/utils/constants.dart';

class ClientHttp {
  Future<UserResponseDto> login(UserRequestDto user) async {
    final response = await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: {'Content-Type': 'application/json'},
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      return UserResponseDto.fromJson(response.body);
    }

    if (response.statusCode == 400) {
      final message = jsonDecode(response.body);
      throw FlutterError(message['message']);
    }

    throw FlutterError('Falha ao realizar login');
  }

  Future<UserResponseDto> loggedUser(String token) async {
    final response = await http.get(
      Uri.parse(Constants.GET_USERS),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return UserResponseDto.fromJson(response.body);
    }

    throw FlutterError('Erro ao buscar dados do usuário');
  }
}
