import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trilhamobileatvd/ui/home_page.dart';
import 'package:trilhamobileatvd/ui/login_page.dart';
import 'package:trilhamobileatvd/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Identification card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0F2027),
          primary: Color(0xFF203A43),
          secondary: Color(0xFF2C5364),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: AppRoutes.LOGIN_PAGE,
      routes: {
        AppRoutes.HOME_PAGE: (ctx) => HomePage(),
        AppRoutes.LOGIN_PAGE: (ctx) => LoginPage(),
      },
    );
  }
}
