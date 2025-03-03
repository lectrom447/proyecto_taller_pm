import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/firebase_options.dart';
import 'package:proyectoprogramovil/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade500),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade500,
          foregroundColor: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.blue.shade500,
          indicatorColor: Colors.blue.shade300,
          iconTheme: WidgetStateProperty.fromMap({
            WidgetState.selected: IconThemeData(color: Colors.white),
            WidgetState.any: IconThemeData(color: Colors.white),
          }),
          labelTextStyle: WidgetStateProperty.fromMap({
            WidgetState.selected: TextStyle(
              // color: Colors.blue.shade100,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            WidgetState.any: TextStyle(color: Colors.white),
          }),
        ),
      ),
      home: const HomePage(),
    );
  }
}
