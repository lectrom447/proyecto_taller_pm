import 'package:flutter/material.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainOptionPage(),
    );
  }
}

class MainOptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido al sistema de gestión del Taller de Mecánica, Juan.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildOptionCard(context, 'Registro de Clientes', Icons.person_add),
                  _buildOptionCard(context, 'Vehículos Ingresados', Icons.directions_car),
                  _buildOptionCard(context, 'Vehículos Terminados', Icons.check_circle),
                  _buildOptionCard(context, 'Gestión de Usuarios', Icons.supervised_user_circle),
                  _buildOptionCard(context, 'Reporte de Facturación', Icons.account_balance_wallet),
                  _buildOptionCard(context, 'Servicios Realizados', Icons.assignment_turned_in),
                ],
              ),
            ),
            SizedBox(height: 16), // Espacio entre el GridView y el FloatingActionButton
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context, 'Nueva Cita', ['Nombre del Cliente', 'Datos del Vehículo', 'Motivo de Ingreso']);
        },
        child: Icon(Icons.add, size: 28),
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Ajusta la ubicación del botón flotante
    );
  }

  Widget _buildOptionCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        onTap: () {
          switch (title) {
            case 'Registro de Clientes':
              _showFormDialog(context, title, ['Nombre', 'Teléfono', 'Correo Electrónico']);
              break;
            case 'Vehículos Ingresados':
              _showFormDialog(context, title, ['Placa', 'Modelo', 'Año', 'Propietario']);
              break;
            case 'Vehículos Terminados':
              _showFormDialog(context, title, ['Placa', 'Fecha de Finalización', 'Observaciones']);
              break;
            case 'Gestión de Usuarios':
              _showFormDialog(context, title, ['Nombre', 'Rol', 'Estado']);
              break;
            case 'Reporte de Facturación':
              _showFormDialog(context, title, ['Fecha de Facturación', 'Monto Total', 'Cliente']);
              break;
            case 'Servicios Realizados':
              _showFormDialog(context, title, ['Placa', 'Fecha de Servicio', 'Descripción']);
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.black),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFormDialog(BuildContext context, String title, List<String> fields) {
    List<TextEditingController> controllers = fields.map((_) => TextEditingController()).toList();
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_note, size: 50, color: Colors.blueAccent),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ...List.generate(fields.length, (index) => _buildTextField(controllers[index], fields[index])),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar', style: TextStyle(color: Colors.red)),
                      ),  
                      ElevatedButton(
                        onPressed: () {
                          for (int i = 0; i < fields.length; i++) {
                            print('${fields[i]}: ${controllers[i].text}');
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                        child: Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
