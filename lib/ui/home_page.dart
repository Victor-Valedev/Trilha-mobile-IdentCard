import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhamobileatvd/model/dto/user_response_dto.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserResponseDto? _user;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final preference = await SharedPreferences.getInstance();
      final userData = preference.getString('logged_user');

      if (userData != null && userData.isNotEmpty) {
        setState(() {
          _user = UserResponseDto.fromJson(userData);
        });
      }
    } on FlutterError catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Erro ao logar'),
              content: Text(e.message),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo ${_user!.firstName}!')),
      body: Container(),
    );
  }
}
