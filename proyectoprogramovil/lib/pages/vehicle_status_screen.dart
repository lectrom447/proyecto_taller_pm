import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class VehicleServiceStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estado del Servicio'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay vehículos registrados.'));
          }

          final vehicles = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index].data() as Map<String, dynamic>;
              final customerId = vehicle['customerId'];

              return FutureBuilder<DocumentSnapshot>(
                future:
                    FirebaseFirestore.instance
                        .collection('customers')
                        .doc(customerId)
                        .get(),
                builder: (context, customerSnapshot) {
                  if (customerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  String customerName = 'Sin nombre';
                  if (customerSnapshot.hasData &&
                      customerSnapshot.data!.exists) {
                    customerName =
                        customerSnapshot.data!.get('fullName') ?? 'Sin nombre';
                  }

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_car,
                        color: Colors.blue,
                        size: 40,
                      ),
                      title: Text(
                        vehicle['model'] ?? 'Modelo desconocido',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Placa: ${vehicle['plateNumber'] ?? 'Sin placa'}\n'
                        'Dueño: $customerName\n'
                        'Estado: ${vehicle['status'] ?? 'Sin estado'}',
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ServiceDetailScreen(
                                    vehicleId: vehicles[index].id,
                                    vehicle: vehicle,
                                    customerName: customerName,
                                  ),
                            ),
                          ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ServiceDetailScreen extends StatefulWidget {
  final String vehicleId;
  final Map<String, dynamic> vehicle;
  final String customerName;

  ServiceDetailScreen({
    required this.vehicleId,
    required this.vehicle,
    required this.customerName,
  });

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.vehicle['model'] ?? 'Modelo desconocido'} - ${widget.vehicle['plateNumber'] ?? 'Sin placa'}',
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('vehicles')
                .doc(widget.vehicleId)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No se encontró el vehículo.'));
          }

          final vehicleData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dueño: ${widget.customerName}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Estado del Servicio: ${vehicleData['status'] ?? 'Sin estado'}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                LinearPercentIndicator(
                  lineHeight: 20.0,
                  percent:
                      vehicleData['status'] == 'Completado'
                          ? 1.0
                          : (vehicleData['status'] == 'En progreso'
                              ? 0.5
                              : 0.2),
                  center: Text(
                    vehicleData['status'] ?? 'Sin estado',
                    style: TextStyle(color: Colors.white),
                  ),
                  progressColor:
                      vehicleData['status'] == 'Completado'
                          ? Colors.green
                          : (vehicleData['status'] == 'En progreso'
                              ? Colors.orange
                              : Colors.red),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(height: 30),
                Text(
                  'Servicios en Progreso:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: vehicleData['services']?.length ?? 0,
                    itemBuilder: (context, index) {
                      final service = vehicleData['services'][index];
                      return ListTile(
                        title: Text(
                          service['service'] ?? 'Servicio desconocido',
                        ),
                        subtitle: Text(
                          'Estado: ${service['status'] ?? 'Sin estado'}',
                        ),
                        trailing: Icon(
                          Icons.check_circle,
                          color:
                              service['status'] == 'Completado'
                                  ? Colors.green
                                  : Colors.orange,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addService(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String serviceName = ''; // Variable para el nombre del servicio
        String serviceStatus = 'Pendiente'; // Estado por defecto

        return AlertDialog(
          title: Text('Agregar Servicio'),
          content: StatefulBuilder(
            builder: (context, setState) {
              // Usamos StatefulBuilder para actualizar el estado
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nombre del Servicio',
                    ),
                    onChanged: (value) => serviceName = value,
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: serviceStatus,
                    items:
                        ['Pendiente', 'En progreso', 'Completado']
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          serviceStatus =
                              value; // Actualiza el estado del DropdownButton
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (serviceName.isEmpty) {
                        // Asegurarse de que el nombre no esté vacío
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Por favor ingrese el nombre del servicio.',
                            ),
                          ),
                        );
                        return;
                      }

                      // Crear el servicio con el nombre proporcionado y el estado seleccionado
                      final service = Service(
                        description: serviceName,
                        cost: 0.0, // Costo por defecto 0
                        serviceDate: Timestamp.now(), // Fecha actual
                        status: serviceStatus,
                        vehicleId: widget.vehicleId,
                      );

                      // Agregar el servicio al vehículo en Firestore
                      await FirebaseFirestore.instance
                          .collection('vehicles')
                          .doc(widget.vehicleId)
                          .update({
                            'services': FieldValue.arrayUnion([
                              service.toMap(),
                            ]),
                          });

                      // Cerrar el diálogo
                      Navigator.pop(context);
                    },
                    child: Text('Agregar'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: VehicleServiceStatusScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    ),
  );
}
