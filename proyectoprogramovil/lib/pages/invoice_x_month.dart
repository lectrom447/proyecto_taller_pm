import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  Map<String, double> totalFacturasPorCliente = {}; // Cliente y total de facturas
  DateTime selectedMonth = DateTime.now(); // Mes seleccionado
  double totalGeneral = 0.0; // Total general de todas las facturas

  @override
  void initState() {
    super.initState();
    obtenerFacturas();
  }

  // Obtener las facturas del mes seleccionado
  Future<void> obtenerFacturas() async {
    try {
      // Referencia a la colección de facturas
      QuerySnapshot invoiceSnapshot = await FirebaseFirestore.instance
          .collection('invoices')
          .where('invoiceDate', isGreaterThanOrEqualTo: DateTime(selectedMonth.year, selectedMonth.month, 1))
          .where('invoiceDate', isLessThan: DateTime(selectedMonth.year, selectedMonth.month + 1, 1))
          .get();

      totalFacturasPorCliente.clear(); // Limpiar el mapa antes de agregar nuevas facturas
      totalGeneral = 0.0; // Reiniciar el total general

      // Procesar cada factura
      for (var doc in invoiceSnapshot.docs) {
        double totalAmount = doc['totalAmount'] ?? 0.0;
        String vehicleId = doc['vehicleId'];

        // Buscar el customerId en la colección vehicles
        DocumentSnapshot vehicleDoc = await FirebaseFirestore.instance
            .collection('vehicles')
            .doc(vehicleId)
            .get();
        String customerId = vehicleDoc['customerId'];

        // Buscar el fullName del cliente en la colección customers
        QuerySnapshot customerDoc = await FirebaseFirestore.instance
            .collection('customers')
            .where('id', isEqualTo: customerId)
            .get();
        String customerName = customerDoc.docs[0]['fullName'];

        // Sumar el total de la factura al cliente correspondiente
        if (totalFacturasPorCliente.containsKey(customerName)) {
          totalFacturasPorCliente[customerName] = totalFacturasPorCliente[customerName]! + totalAmount;
        } else {
          totalFacturasPorCliente[customerName] = totalAmount;
        }

        // Sumar al total general
        totalGeneral += totalAmount;
      }

      // Actualizar la interfaz de usuario
      setState(() {});
    } catch (e) {
      print('Error al obtener facturas: $e');
    }
  }

  // Seleccionar un mes
  Future<void> selectMonth() async {
    DateTime? pickedMonth = await showMonthPicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedMonth != null && pickedMonth != selectedMonth) {
      setState(() {
        selectedMonth = pickedMonth;
      });
      obtenerFacturas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total de Facturas por Mes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: selectMonth, // Mostrar el selector de mes
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Mes seleccionado: ${selectedMonth.month}/${selectedMonth.year}',
              style: TextStyle(fontSize: 16),
            ),
            totalFacturasPorCliente.isEmpty
                ? Center(child: Text('Cargando facturas...'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: totalFacturasPorCliente.length,
                      itemBuilder: (context, index) {
                        String cliente = totalFacturasPorCliente.keys.elementAt(
                          index,
                        );
                        double total = totalFacturasPorCliente[cliente]!;

                        return Card(
                          child: ListTile(
                            title: Text(cliente),
                            subtitle: Text(
                              'Total de facturas: \$${total.toStringAsFixed(2)}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total General: \$${totalGeneral.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
