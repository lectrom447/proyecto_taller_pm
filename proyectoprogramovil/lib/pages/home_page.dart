import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/custom_button.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _handleLogut(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.cleanCurrentProfile();
    await FirebaseAuth.instance.signOut();
  }

  _handleRegister(BuildContext context) async {
    Navigator.of(context).pushNamed('add_workshop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomButton(
                text: 'Logout',
                onPressed: () => _handleLogut(context),
              ),
              CustomButton(
                text: 'Registrar Taller',
                onPressed: () => _handleRegister(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
