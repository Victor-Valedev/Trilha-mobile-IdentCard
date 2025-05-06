import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhamobileatvd/components/drawer_component.dart';
import 'package:trilhamobileatvd/components/user_card.dart';
import 'package:trilhamobileatvd/model/dto/user_response_dto.dart';
import 'package:trilhamobileatvd/service/client_http.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserResponseDto? _user;
  ClientHttp? clientHttp;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final preference = await SharedPreferences.getInstance();

      final userData = preference.getString('logged_user');
      final token = preference.getString('auth_token');

      if (userData != null && userData.isNotEmpty) {
        setState(() {
          _user = UserResponseDto.fromJson(userData);
        });
      }

      if (token != null && token.isNotEmpty) {
        final updateUser = await clientHttp!.loggedUser(token);

        await preference.setString('logged_user', updateUser.toJson());

        setState(() {
          _user = updateUser;
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
    } catch (e) {
      print('Erro inesperado: $e ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo, ${_user!.firstName}!')),
      drawer: DrawerComponent(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'IDENTIFICATION CARD',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Divider(),
                UserCard(user: _user!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Country: ${_user!.address.country} ',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontSize: 15),
                    ),
                    SizedBox(width: 90),
                    Text(
                      'Age: ${_user!.age}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
