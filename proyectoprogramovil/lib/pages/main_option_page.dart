import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainOptionPage(),
//     );
//   }
// }

class MainOptionPage extends StatelessWidget {
  const MainOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Bienvenido al sistema de gestión del Taller de Mecánica, ${FirebaseAuth.instance.currentUser!.displayName}.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  if (appState.currentProfile!.role == 'admin')
                    _buildOptionCard(context, 'Acess Codes', Icons.password),
                  if (appState.currentProfile!.role == 'admin')
                    _buildOptionCard(
                      context,
                      'Add Product',
                      Icons.addchart_rounded,
                    ),
                  _buildOptionCard(context, 'Customers', Icons.people_alt),
                  _buildOptionCard(context, 'Vehicles', Icons.car_crash),

                  // if (appState.currentProfile!.role == 'admin')
                  //   _buildOptionCard(
                  //     context,
                  //     'Gestión de Usuarios',
                  //     Icons.supervised_user_circle,
                  //   ),
                  if (appState.currentProfile!.role == 'admin' ||
                      appState.currentProfile!.role == 'cashier')
                    _buildOptionCard(
                      context,
                      'Billing Report',
                      Icons.account_balance_wallet,
                    ),
                  if (appState.currentProfile!.role == 'admin' ||
                      appState.currentProfile!.role == 'cashier')
                    _buildOptionCard(context, 'Discounts', Icons.discount),
                  if (appState.currentProfile!.role == 'admin')
                    _buildOptionCard(
                      context,
                      'Add Discount',
                      Icons.discount_outlined,
                    ),
                  if (appState.currentProfile!.role == 'cashier')
                    _buildOptionCard(context, 'Add Invoice', Icons.receipt),
                  // _buildOptionCard(
                  //   context,
                  //   'Servicios Realizados',
                  //   Icons.assignment_turned_in,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ), // Espacio entre el GridView y el FloatingActionButton
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          switch (title) {
            case 'Acess Codes':
              Navigator.of(context).pushNamed('access_codes');
              break;
            case 'Customers':
              Navigator.of(context).pushNamed('customers');
              break;
            case 'Billing Report':
              Navigator.of(context).pushNamed('billing_report');
            case 'Add Invoice':
              Navigator.of(context).pushNamed('add_invoice');
            case 'Vehicles':
              Navigator.of(context).pushNamed('list_vehicles');

              break;
            case 'Add Product':
              Navigator.of(context).pushNamed('add_product');
            case 'Discounts':
              Navigator.of(context).pushNamed('list_discounts');
            case 'Add Discount':
              Navigator.of(context).pushNamed('add_discount');

              break;
            case 'Gestión de Usuarios':
              break;
            case 'Reporte de Facturación':
              break;
            case 'Servicios Realizados':
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(30),
          //   color: Colors.white,
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black26,
          //       blurRadius: 6,
          //       offset: Offset(0, 4),
          //     ),
          //   ],
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.grey.shade800),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showFormDialog(
  //   BuildContext context,
  //   String title,
  //   List<String> fields,
  // ) {
  //   List<TextEditingController> controllers =
  //       fields.map((_) => TextEditingController()).toList();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(Icons.edit_note, size: 50, color: Colors.blueAccent),
  //                 SizedBox(height: 10),
  //                 Text(
  //                   title,
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(height: 16),
  //                 ...List.generate(
  //                   fields.length,
  //                   (index) =>
  //                       _buildTextField(controllers[index], fields[index]),
  //                 ),
  //                 SizedBox(height: 20),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text(
  //                         'Cancelar',
  //                         style: TextStyle(color: Colors.red),
  //                       ),
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         for (int i = 0; i < fields.length; i++) {
  //                           print('${fields[i]}: ${controllers[i].text}');
  //                         }
  //                         Navigator.pop(context);
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.lightBlue,
  //                       ),
  //                       child: Text('Guardar'),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildTextField(TextEditingController controller, String hintText) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: hintText,
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  //       ),
  //     ),
  //   );
  // }
}
