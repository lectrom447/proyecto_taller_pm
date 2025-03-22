import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/firebase_options.dart';
import 'package:proyectoprogramovil/pages/add_customer_page.dart';
import 'package:proyectoprogramovil/pages/pages.dart';
import 'package:proyectoprogramovil/state/app_state.dart';
import 'package:proyectoprogramovil/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightSolidTheme,
      initialRoute: 'main',
      routes: {
        'main': (_) => MainAuthGuard(),
        // 'login': (_) => LoginPage(),
        'add_customer': (_) => AddCustomerPage(),
        'add_workshop': (_) => AddWorkshopPage(),
      },
    );
  }
}
