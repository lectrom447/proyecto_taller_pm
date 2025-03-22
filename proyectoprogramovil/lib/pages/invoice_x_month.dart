import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  Map<String, List<Map<String, dynamic>>> facturasPorCliente = {}; // Cliente y sus facturas
  DateTime selectedMonth = DateTime.now(); // Mes seleccionado
  Set<String> autosPorMes = {};
  double totalGeneral = 0.0; // Total general de todas las facturas
  int cantidadFacturas = 0;

  @override
  void initState() {
    super.initState();
    obtenerFacturas();
  }

  // Obtener las facturas del mes seleccionado
  Future<void> obtenerFacturas() async {
    try {
      QuerySnapshot invoiceSnapshot = await FirebaseFirestore.instance
          .collection('invoices')
          .where(
            'invoiceDate',
            isGreaterThanOrEqualTo: DateTime(
              selectedMonth.year,
              selectedMonth.month,
              1,
            ),
          )
          .where(
            'invoiceDate',
            isLessThan: DateTime(
              selectedMonth.year,
              selectedMonth.month + 1,
              1,
            ),
          )
          .get();

      facturasPorCliente.clear();
      totalGeneral = 0.0;
      autosPorMes.clear();
      cantidadFacturas = 0;

      for (var doc in invoiceSnapshot.docs) {
        double totalAmount = doc['totalAmount'] ?? 0.0;
        String vehicleId = doc['vehicleId'];
        cantidadFacturas++;
        autosPorMes.add(vehicleId);

        DocumentSnapshot vehicleDoc = await FirebaseFirestore.instance
            .collection('vehicles')
            .doc(vehicleId)
            .get();
        String customerId = vehicleDoc['customerId'];

        QuerySnapshot customerDoc = await FirebaseFirestore.instance
            .collection('customers')
            .where('id', isEqualTo: customerId)
            .get();
        String customerName = customerDoc.docs[0]['fullName'];

        Map<String, dynamic> factura = {
          'totalAmount': totalAmount,
          'invoiceDate': (doc['invoiceDate'] as Timestamp).toDate(),
        };

        if (facturasPorCliente.containsKey(customerName)) {
          facturasPorCliente[customerName]!.add(factura);
        } else {
          facturasPorCliente[customerName] = [factura];
        }

        totalGeneral += totalAmount;
      }

      setState(() {});
    } catch (e) {
      print('Error al obtener facturas: $e');
    }
  }

  Future<void> mostrarDetallesFactura(
      String cliente, List<Map<String, dynamic>> facturas) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalles de facturas de $cliente'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: facturas.length,
              itemBuilder: (context, index) {
                var factura = facturas[index];
                return ListTile(
                  title: Text(
                    'Monto: \$${factura['totalAmount'].toStringAsFixed(2)}',
                  ),
                  subtitle: Text(
                    'Fecha: ${factura['invoiceDate'].day}/${factura['invoiceDate'].month}/${factura['invoiceDate'].year}',
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Facturas por Mes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.directions_car, size: 20, color: Colors.white),
                Text(
                  ' x ${autosPorMes.length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: selectMonth,
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
            facturasPorCliente.isEmpty
                ? Center(child: Text('Cargando facturas...'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: facturasPorCliente.length,
                      itemBuilder: (context, index) {
                        String cliente =
                            facturasPorCliente.keys.elementAt(index);
                        double total = facturasPorCliente[cliente]!
                            .fold(0.0, (sum, factura) => sum + factura['totalAmount']);

                        return Card(
                          child: ListTile(
                            title: Text(cliente),
                            subtitle: Text(
                              'Total de facturas: \$${total.toStringAsFixed(2)}',
                            ),
                            onLongPress: () => mostrarDetallesFactura(
                              cliente,
                              facturasPorCliente[cliente]!,
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
