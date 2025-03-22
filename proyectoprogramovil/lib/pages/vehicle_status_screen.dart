import 'package:flutter/material.dart';
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

              return FutureBuilder<QuerySnapshot>(
                future:
                    FirebaseFirestore.instance
                        .collection('customers')
                        .where(
                          'id',
                          isEqualTo: customerId,
                        ) // Filtramos por el campo 'customerId'
                        .get(),
                builder: (context, customerSnapshot) {
                  if (customerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  String customerName = 'Sin nombre';
                  if (customerSnapshot.hasData &&
                      customerSnapshot.data!.docs.isNotEmpty) {
                    // Obtenemos el primer documento que coincida con el customerId
                    customerName =
                        customerSnapshot.data!.docs[0].get('fullName') ??
                        'Sin nombre';
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
                        'Dueño: $customerName\n',
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
                          service['description'] ?? 'Servicio desconocido',
                        ),
                        subtitle: Text(
                          'Estado: ${service['status'] ?? 'Sin estado'}',
                        ),
                        trailing: Icon(
                          Icons.check_circle,
                          color:
                              service['status'] == 'Pendiente'
                                  ? Colors.red
                                  : service['status'] == 'En progreso'
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                        onLongPress: () {
                          _editServiceStatus(context, index);
                        },
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

  void _editServiceStatus(BuildContext context, int serviceIndex) {
    String newStatus =
        widget.vehicle['services'][serviceIndex]['status'] ?? 'Pendiente';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Estado del Servicio'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<String>(
                value: newStatus,
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
                      newStatus = value;
                    });
                  }
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Obtener el documento actualizado del vehículo
                DocumentSnapshot vehicleDoc =
                    await FirebaseFirestore.instance
                        .collection('vehicles')
                        .doc(widget.vehicleId)
                        .get();

                if (vehicleDoc.exists) {
                  // Copia profunda del arreglo de servicios para evitar problemas de referencia
                  List<dynamic> services = List.from(
                    vehicleDoc['services'] ?? [],
                  );

                  // Actualizar el estado del servicio correspondiente
                  services[serviceIndex]['status'] = newStatus;

                  // Actualizar el documento en Firestore
                  await FirebaseFirestore.instance
                      .collection('vehicles')
                      .doc(widget.vehicleId)
                      .update({'services': services});

                  // Actualizar el estado local del widget para reflejar los cambios inmediatamente
                  setState(() {
                    widget.vehicle['services'][serviceIndex]['status'] =
                        newStatus;
                  });

                  Navigator.pop(
                    context,
                  ); // Cerrar el diálogo después de guardar
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _addService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String serviceName = ''; // Nombre del servicio
        String serviceStatus = 'Pendiente'; // Estado del servicio
        String selectedProduct = ''; // Producto seleccionado
        int quantity = 1; // Cantidad de productos
        double productPrice = 0.0; // Precio del producto seleccionado
        double total = 0.0; // Total del servicio

        return AlertDialog(
          title: Text('Agregar Servicio'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nombre del servicio
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nombre del Servicio',
                    ),
                    onChanged: (value) => serviceName = value,
                  ),
                  SizedBox(height: 10),

                  // Selección de producto como TextField
                  FutureBuilder<QuerySnapshot>(
                    future:
                        FirebaseFirestore.instance.collection('products').get(),
                    builder: (context, productSnapshot) {
                      if (productSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!productSnapshot.hasData ||
                          productSnapshot.data!.docs.isEmpty) {
                        return Text('No hay productos disponibles.');
                      }

                      final products = productSnapshot.data!.docs;
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Selecciona un Producto',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value:
                              selectedProduct.isEmpty ? null : selectedProduct,
                          items:
                              products.map((productDoc) {
                                final productData =
                                    productDoc.data() as Map<String, dynamic>;
                                final productName =
                                    productData['name'] ??
                                    'Producto desconocido';
                                return DropdownMenuItem<String>(
                                  value: productName,
                                  child: Text(productName),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedProduct = value!;
                              // Obtener el precio del producto seleccionado
                              final selectedProductData = products.firstWhere(
                                (productDoc) =>
                                    productDoc['name'] == selectedProduct,
                              );
                              productPrice =
                                  selectedProductData['price'] ?? 0.0;
                              total =
                                  productPrice * quantity; // Calcular el total
                            });
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),

                  // Cantidad
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Cantidad'),
                    onChanged: (value) {
                      quantity = int.tryParse(value) ?? 1;
                      total = productPrice * quantity; // Recalcular el total
                    },
                  ),
                  SizedBox(height: 10),

                  // Estado
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
                          serviceStatus = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),

                  // Botón de agregar
                  ElevatedButton(
                    onPressed: () async {
                      if (serviceName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Por favor ingrese el nombre del servicio.',
                            ),
                          ),
                        );
                        return;
                      }

                      final service = Service(
                        description: serviceName,
                        serviceDate: Timestamp.now(),
                        status: serviceStatus,
                        vehicleId: widget.vehicleId,
                        products: [
                          Product(name: selectedProduct, quantity: quantity),
                        ],
                        total: total, // Agregar el total al servicio
                      );

                      await FirebaseFirestore.instance
                          .collection('vehicles')
                          .doc(widget.vehicleId)
                          .update({
                            'services': FieldValue.arrayUnion([
                              service.toMap(),
                            ]),
                          });

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
