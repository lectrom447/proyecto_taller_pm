import 'package:flutter/material.dart';

class ClienteInfoPage extends StatelessWidget {
  const ClienteInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Información del Cliente')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildClienteCard(),
            SizedBox(height: 16.0),
            _buildVehiculosSection(),
            SizedBox(height: 16.0),
            _buildServiciosSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildClienteCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: Juan Pérez', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Teléfono: +123456789'),
            Text('Dirección: Calle 123, Ciudad XYZ'),
          ],
        ),
      ),
    );
  }

  Widget _buildVehiculosSection() {
    List<Map<String, String>> vehiculos = [
      {'marca': 'Toyota', 'modelo': 'Corolla', 'año': '2020'},
      {'marca': 'Ford', 'modelo': 'Focus', 'año': '2018'},
    ];
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vehículos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Column(
              children: vehiculos.map((vehiculo) {
                return ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('${vehiculo['marca']} ${vehiculo['modelo']}'),
                  subtitle: Text('Año: ${vehiculo['año']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiciosSection() {
    List<Map<String, String>> servicios = [
      {'fecha': '10/02/2024', 'descripcion': 'Cambio de aceite'},
      {'fecha': '15/03/2024', 'descripcion': 'Alineación y balanceo'},
    ];
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Servicios Realizados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Column(
              children: servicios.map((servicio) {
                return ListTile(
                  leading: Icon(Icons.build),
                  title: Text(servicio['descripcion']!),
                  subtitle: Text('Fecha: ${servicio['fecha']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}