import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhamobileatvd/utils/routes.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
              ),
            ),
            child: Text(
              'Menu',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () async {
              final preferencia = await SharedPreferences.getInstance();
              await preferencia.clear();

              if (!context.mounted) {
                return;
              }

              Navigator.pushReplacementNamed(context, AppRoutes.LOGIN_PAGE);
            },
          ),
        ],
      ),
    );
  }
}
