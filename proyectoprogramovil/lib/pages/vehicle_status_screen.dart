import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VehicleServiceStatusScreen extends StatelessWidget {
  final List<Map<String, String>> vehicles = [
    {
      'plate': 'ABC-123',
      'model': 'Toyota Corolla',
      'owner': 'Juan Pérez',
      'status': 'En progreso'
    },
    {
      'plate': 'XYZ-789',
      'model': 'Honda Civic',
      'owner': 'María Gómez',
      'status': 'Completado'
    },
    {
      'plate': 'LMN-456',
      'model': 'Ford Focus',
      'owner': 'Carlos Rodríguez',
      'status': 'En espera'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado del Servicio'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.directions_car, color: Colors.blue, size: 40),
              title: Text(vehicle['model']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text('Placa: ${vehicle['plate']}\nDueño: ${vehicle['owner']}\nEstado: ${vehicle['status']}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDetailScreen(vehicle: vehicle),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServiceDetailScreen extends StatelessWidget {
  final Map<String, String> vehicle;

  ServiceDetailScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${vehicle['model']} - ${vehicle['plate']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dueño: ${vehicle['owner']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Estado del Servicio: ${vehicle['status']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            LinearPercentIndicator(
              lineHeight: 20.0,
              percent: vehicle['status'] == 'Completado' ? 1.0 : (vehicle['status'] == 'En progreso' ? 0.5 : 0.2),
              center: Text(vehicle['status']!, style: TextStyle(color: Colors.white)),
              progressColor: vehicle['status'] == 'Completado' ? Colors.green : (vehicle['status'] == 'En progreso' ? Colors.orange : Colors.red),
              backgroundColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VehicleServiceStatusScreen(),
    theme: ThemeData(primarySwatch: Colors.blue),
  ));
}
