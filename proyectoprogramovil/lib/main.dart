import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/firebase_options.dart';
import 'package:proyectoprogramovil/pages/add_customer_page.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade500),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 25,
            color: Colors.white,
            // color: Colors.grey.shade800,
          ),

          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        // appBarTheme: AppBarTheme(
        //   // backgroundColor: Colors.blue.shade500,
        //   foregroundColor: Colors.grey.shade900,
        // ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.blue.shade700,
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
        // navigationBarTheme: NavigationBarThemeData(
        //   backgroundColor: Colors.white,
        //   indicatorColor: Colors.blue.shade500,
        //   iconTheme: WidgetStateProperty.fromMap({
        //     WidgetState.selected: IconThemeData(color: Colors.white),
        //     WidgetState.any: IconThemeData(color: Colors.grey.shade600),
        //   }),
        //   labelTextStyle: WidgetStateProperty.fromMap({
        //     WidgetState.selected: TextStyle(
        //       // color: Colors.blue.shade100,
        //       color: Colors.blue.shade500,
        //       fontWeight: FontWeight.bold,
        //     ),
        //     WidgetState.any: TextStyle(color: Colors.grey.shade600),
        //   }),
        // ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.disabled: Colors.grey.shade400,
              WidgetState.any: Colors.blue.shade700,
            }),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.blue.shade700),
          labelStyle: TextStyle(color: Colors.grey.shade700),
          // filled: true,
          // fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.blue.shade700,
              // style: BorderStyle.none,
            ),
          ),
        ),
      ),
      initialRoute: 'main',
      routes: {
        'main': (_) => MainPage(),
        'add_customer': (_) => AddCustomerPage(),
      },
    );
  }
}
