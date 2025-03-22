import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class NoProfileFoundPage extends StatelessWidget {
  const NoProfileFoundPage({super.key});

  void _fandleRegisterWorkshop(BuildContext context) async {
    await Navigator.of(context).pushNamed('add_workshop');
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed('main');
  }

  _handleLogut(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.cleanCurrentProfile();
    await FirebaseAuth.instance.signOut();
  }

  _handleJoin(BuildContext context) async {
    await Navigator.of(context).pushNamed('join_workshop');
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed('main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First steps')),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 24, color: Colors.grey.shade800),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10),
            Text('It looks like you\'re not part of a workshop yet.'),
            SizedBox(height: 10),
            Card(
              color: Colors.grey.shade200,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join a workshop using an access code provided by the administrator.',
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Join now!',
                      color: Colors.green.shade500,
                      expand: true,
                      onPressed: () => _handleJoin(context),
                    ),
                    // Text(
                    //   textAlign: TextAlign.end,
                    //   _user.email!,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text('Or register your own workshop below:'),
                    SizedBox(height: 5),
                    CustomButton(
                      text: 'Register your workshop now!',
                      expand: true,
                      onPressed: () => _fandleRegisterWorkshop(context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('If you need to change your account:'),
            SizedBox(height: 5),
            CustomButton(
              color: Colors.red,
              text: 'Logout',
              expand: true,
              onPressed: () => _handleLogut(context),
            ),
          ],
        ),
      ),
    );
  }
}
