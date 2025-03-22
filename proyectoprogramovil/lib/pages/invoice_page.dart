import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  TextEditingController servicioController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController codigoDescuentoController = TextEditingController();

  double descuento = 0.0;
  List<Vehicle> vehicles = []; // List of vehicles
  String? selectedVehicleId;
  List<Map<String, dynamic>> selectedVehicleServices = [];

  // Function to fetch vehicles
  Future<void> fetchVehicles() async {
    final appState = Provider.of<AppState>(context, listen: false);
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('vehicles')
              .where(
                'workshopId',
                isEqualTo: appState.currentProfile!.workshopId,
              )
              .get();

      setState(() {
        vehicles =
            querySnapshot.docs
                .map((doc) => Vehicle.fromFirestore(doc, SnapshotOptions()))
                .toList();
      });
    } catch (e) {
      print('Error al obtener vehículos: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVehicles(); // Fetch vehicles
  }

  // Function to fetch services of selected vehicle
  Future<void> fetchServicesForVehicle(String vehicleDocId) async {
    try {
      final vehicleDoc =
          await FirebaseFirestore.instance
              .collection('vehicles')
              .doc(vehicleDocId)
              .get();

      // Assuming services are stored inside a 'services' field in each vehicle document
      if (vehicleDoc.exists) {
        var servicesData = vehicleDoc['services'];
        if (servicesData != null) {
          setState(() {
            selectedVehicleServices = List<Map<String, dynamic>>.from(
              servicesData,
            );
            print(selectedVehicleServices);
          });
        }
      }
    } catch (e) {
      print('Error al obtener servicios para el vehículo: $e');
    }
  }

  double calcularTotal() {
    double total = selectedVehicleServices.fold(
      0,
      (total, item) => total + item['total'],
    );
    return total - (total * descuento);
  }

  void aplicarDescuento() async {
    String codigo = codigoDescuentoController.text;

    if (codigo.isEmpty) {
      setState(() {
        descuento = 0.0; // Sin código, no hay descuento
      });
      return;
    }

    try {
      // Referencia a la colección 'discounts'
      CollectionReference descuentosRef = FirebaseFirestore.instance.collection(
        'discounts',
      );

      // Buscar documento con el código de descuento ingresado
      QuerySnapshot querySnapshot =
          await descuentosRef.where('codeName', isEqualTo: codigo).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Suponiendo que el descuento está en el campo 'porcentaje'
        double porcentaje = querySnapshot.docs.first.get('amount').toDouble();
        setState(() {
          descuento = porcentaje / 100;
        });
        print('Descuento aplicado: $descuento%');
      } else {
        setState(() {
          descuento = 0.0;
        });
        print('Código de descuento no válido');
      }
    } catch (e) {
      print('Error al buscar el descuento: $e');
      setState(() {
        descuento = 0.0;
      });
    }
  }

  void generarFactura() async {
    final appState = Provider.of<AppState>(context, listen: false);

    if (selectedVehicleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Completa todos los campos y agrega al menos un servicio.',
          ),
        ),
      );
      return;
    }

    try {
      double totalAmount =
          calcularTotal(); // Utilizamos la función calcularTotal() para obtener el total
      String vehicleId = selectedVehicleId!;
      DateTime invoiceDate = DateTime.now();
      bool isPaid = true;

      // Referencia a la colección 'invoices'
      CollectionReference invoicesRef = FirebaseFirestore.instance.collection(
        'invoices',
      );

      // Crear el documento con los datos de la factura
      await invoicesRef.add({
        'totalAmount': totalAmount,
        'vehicleId': vehicleId,
        'invoiceDate': invoiceDate,
        'isPaid': isPaid,
        'workshopId': appState.currentProfile!.workshopId,
      });
      if (!mounted) return;
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Factura generada exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      print('Factura generada con éxito');
    } catch (e) {
      print('Error al generar la factura: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al generar la factura. Inténtalo de nuevo.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar Factura'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown to select vehicle
            DropdownButtonFormField<String>(
              value: selectedVehicleId,
              hint: Text('Seleccionar Vehículo'),
              onChanged: (String? value) {
                setState(() {
                  selectedVehicleId = value;
                });
                if (value != null) {
                  fetchServicesForVehicle(value);
                }
              },
              items:
                  vehicles.map((Vehicle vehicle) {
                    return DropdownMenuItem<String>(
                      value: vehicle.id,
                      child: Text(vehicle.model!),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            // Show services of selected vehicle
            if (selectedVehicleServices.isNotEmpty) ...[
              Text(
                'Servicios del vehículo:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedVehicleServices.length,
                itemBuilder: (context, index) {
                  var service = selectedVehicleServices[index];
                  return Card(
                    child: ListTile(
                      title: Text(service['description']),
                      subtitle: Text(
                        '\$${service['total'].toStringAsFixed(2)}',
                      ),
                    ),
                  );
                },
              ),
            ],
            SizedBox(height: 10),
            // Remove manual entry fields for service and cost
            if (selectedVehicleServices.isEmpty) ...[Row(children: [
                 
                ],
              )],
            SizedBox(height: 10),
            _buildTextField(
              codigoDescuentoController,
              'Código de Descuento',
              Icons.discount,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: aplicarDescuento,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Aplicar Descuento'),
            ),
            SizedBox(height: 10),
            Text(
              'Total: \$${calcularTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generarFactura,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Generar Factura'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
