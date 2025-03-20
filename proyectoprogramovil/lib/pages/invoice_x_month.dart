import 'package:flutter/material.dart';

class Invoice {
  final String cliente;
  final String vehiculo;
  final List<Map<String, dynamic>> servicios;
  final double total;
  final DateTime fecha;

  Invoice({
    required this.cliente,
    required this.vehiculo,
    required this.servicios,
    required this.total,
    required this.fecha,
  });
}

class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  // Ejemplo de facturas con fechas de ejemplo
  List<Invoice> facturas = [
    Invoice(
      cliente: "Cliente 1",
      vehiculo: "Auto 1",
      servicios: [
        {'servicio': 'Cambio de aceite', 'costo': 50.0},
        {'servicio': 'Revisión general', 'costo': 30.0},
      ],
      total: 80.0,
      fecha: DateTime(2025, 3, 1),
    ),
    Invoice(
      cliente: "Cliente 2",
      vehiculo: "Auto 2",
      servicios: [
        {'servicio': 'Reparación frenos', 'costo': 120.0},
        {'servicio': 'Cambio de llantas', 'costo': 150.0},
      ],
      total: 270.0,
      fecha: DateTime(2025, 3, 3),
    ),
  ];

  double calcularTotalFacturas() {
    return facturas.fold(0, (total, factura) => total + factura.total);
  }

  void eliminarFactura(int index) {
    setState(() {
      facturas.removeAt(index);
    });
  }

  void verDetallesFactura(Invoice factura) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Detalles de la Factura"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Cliente: ${factura.cliente}"),
              Text("Vehículo: ${factura.vehiculo}"),
              SizedBox(height: 10),
              ...factura.servicios.map((servicio) {
                return Text("${servicio['servicio']}: \$${servicio['costo']}");
              }).toList(),
              SizedBox(height: 10),
              Text("Total: \$${factura.total.toStringAsFixed(2)}"),
              SizedBox(height: 10),
              Text("Fecha: ${factura.fecha.toLocal().toString().split(' ')[0]}"), // Formato de fecha
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facturas del Mes'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total de todas las facturas: \$${calcularTotalFacturas().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: facturas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(facturas[index].cliente),
                      subtitle: Text(
                          'Fecha: ${facturas[index].fecha.toLocal().toString().split(' ')[0]} | Total: \$${facturas[index].total.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye, color: Colors.blue),
                            onPressed: () {
                              verDetallesFactura(facturas[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              eliminarFactura(index);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        verDetallesFactura(facturas[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
