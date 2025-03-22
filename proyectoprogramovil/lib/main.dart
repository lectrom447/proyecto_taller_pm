import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/firebase_options.dart';
import 'package:proyectoprogramovil/pages/access_codes_page.dart';
import 'package:proyectoprogramovil/pages/add_access_code_page.dart';
import 'package:proyectoprogramovil/pages/add_customer_page.dart';
import 'package:proyectoprogramovil/pages/discount_list_page.dart';
import 'package:proyectoprogramovil/pages/join_workshop_page.dart';
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
        'add_customer': (_) => AddCustomerPage(),
        'add_workshop': (_) => AddWorkshopPage(),
        'access_codes': (_) => AccessCodesPage(),
        'add_access_code': (_) => AddAccessCodePage(),
        'join_workshop': (_) => JoinWorkshopPage(),
        'customers': (_) => CustomersPage(),
        'billing_report': (_) => InvoiceListPage(),
        'add_invoice': (_) => InvoicePage(),
        'list_vehicles': (_) => VehicleServiceStatusScreen(),
        'add_product': (_) => AddProductPage(),
        'list_discounts': (_) => DiscountListScreen(),
        'add_discount': (_) => DiscountPage(),
      },
    );
  }
}
