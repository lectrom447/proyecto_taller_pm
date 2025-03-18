import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/pages/login_page.dart';
import 'package:proyectoprogramovil/pages/register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'auth/login',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case 'auth/login':
            builder = (BuildContext _) => LoginPage();
            break;
          case 'auth/register':
            builder = (BuildContext _) => RegisterPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
