import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  TextEditingController clienteController = TextEditingController();
  TextEditingController vehiculoController = TextEditingController();
  TextEditingController servicioController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController codigoDescuentoController = TextEditingController(); // Controlador para código de descuento

  List<Map<String, dynamic>> servicios = [];
  double descuento = 0.0; // Variable para almacenar el porcentaje de descuento

  void agregarServicio() {
    String servicio = servicioController.text;
    double? costo = double.tryParse(costoController.text);

    if (servicio.isNotEmpty && costo != null) {
      setState(() {
        servicios.add({'servicio': servicio, 'costo': costo});
        servicioController.clear();
        costoController.clear();
      });
    }
  }

  double calcularTotal() {
    double total = servicios.fold(0, (total, item) => total + item['costo']);
    return total - (total * descuento / 100); // Aplicar descuento al total
  }

  void aplicarDescuento() {
    String codigo = codigoDescuentoController.text;

    setState(() {
      if (codigo == 'DESCUENTO10') {
        descuento = 10.0; // Aplicar 10% de descuento
      } else if (codigo == 'DESCUENTO15') {
        descuento = 15.0; // Aplicar 15% de descuento
      } else if (codigo == 'DESCUENTO20') {
        descuento = 20.0; // Aplicar 20% de descuento
      } else {
        descuento = 0.0; // Si el código no es válido, no hay descuento
      }
    });
  }

  void generarFactura() {
    if (clienteController.text.isEmpty || vehiculoController.text.isEmpty || servicios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Completa todos los campos y agrega al menos un servicio.')),
      );
      return;
    }

    // Aquí puedes generar un PDF o guardar los datos en la base de datos
    print('Factura generada');
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
            _buildTextField(clienteController, 'Nombre del Cliente', Icons.person),
            SizedBox(height: 10),
            _buildTextField(vehiculoController, 'Datos del Vehículo', Icons.directions_car),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildTextField(servicioController, 'Servicio', Icons.build)),
                SizedBox(width: 10),
                Expanded(child: _buildTextField(costoController, 'Costo', Icons.attach_money, isNumber: true)),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.green, size: 30),
                  onPressed: agregarServicio,
                ),
              ],
            ),
            SizedBox(height: 10),
            // Campo para ingresar el código de descuento
            _buildTextField(codigoDescuentoController, 'Código de Descuento', Icons.discount),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: aplicarDescuento,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Aplicar Descuento'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: servicios.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(servicios[index]['servicio']),
                      subtitle: Text('\$${servicios[index]['costo'].toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            servicios.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
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

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {bool isNumber = false}) {
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
