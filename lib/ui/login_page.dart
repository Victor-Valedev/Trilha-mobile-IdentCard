import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhamobileatvd/model/dto/user_request_dto.dart';
import 'package:trilhamobileatvd/service/client_http.dart';
import 'package:trilhamobileatvd/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ClientHttp clientHttp = ClientHttp();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Identification card')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Seja bem-vindo(a)!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Text(
                'Faça login para continuar',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username: ',
                    prefixIcon: Icon(Icons.email),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo com seu username.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password: ",
                    prefixIcon: Icon(Icons.password),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo com sua senha.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_isLoading) return;
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          final userResponse = await clientHttp.login(
                            UserRequestDto(
                              username: usernameController.text,
                              password: passwordController.text,
                            ),
                          );

                          final preference = await SharedPreferences.getInstance();

                          await preference.setString(
                            'auth_token',
                            userResponse.accessToken,
                          );

                          final users = await clientHttp.loggedUser(
                            userResponse.accessToken,
                          );

                          await preference.setString(
                            'logged_user',
                            userResponse.toJson(),
                          );

                          await preference.setString(
                            'logged_user',
                            users.toJson(),
                          );

                          if (!context.mounted) {
                            return;
                          }

                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.HOME_PAGE,
                          );
                        } on FlutterError catch (e) {
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: Text('Erro ao logar'),
                                  content: Text(e.message),
                                ),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    child:
                        _isLoading
                            ? CircularProgressIndicator()
                            : Text('Login'),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text('Login de Teste'),
                          content: Text(
                            'Username: michaelw \nPassword: michaelwpass',
                          ),
                        ),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(decoration: TextDecoration.underline),
                ),
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
