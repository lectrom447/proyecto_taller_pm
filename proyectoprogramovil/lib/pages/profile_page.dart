import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/custom_button.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  _handleLogut(BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.cleanCurrentProfile();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey.shade400,
                  ),
                  child: Center(
                    child: Text(
                      user.displayName!.substring(0, 1),
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName!,
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email!,
                      style: TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Role: ${appState.currentProfile!.role}',
                      style: TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomButton(
              color: Colors.red.shade400,
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
