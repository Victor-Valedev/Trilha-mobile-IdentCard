import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                ListTile(
                  contentPadding: EdgeInsets.all(12),
                  tileColor: Colors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _user!.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID ${_user!.id}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${_user!.firstName} ${_user!.lastName}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Gender: ${_user!.gender}',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ),
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
