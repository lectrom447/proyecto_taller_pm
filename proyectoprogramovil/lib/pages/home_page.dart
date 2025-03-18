import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _handleLogut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SizedBox(
        width: double.infinity,
        child: CustomButton(text: 'Logout', onPressed: _handleLogut),
      ),
    );
  }
}
