import 'package:flutter/material.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController porcentajeController = TextEditingController();
  List<Map<String, dynamic>> descuentos = []; // Lista para almacenar los códigos de descuento

  void guardarDescuento() {
    String codigo = codigoController.text.trim();
    double? porcentaje = double.tryParse(porcentajeController.text);

    if (codigo.isNotEmpty && porcentaje != null && porcentaje > 0) {
      setState(() {
        descuentos.add({'codigo': codigo, 'descuento': porcentaje}); // Agregar el nuevo descuento a la lista
      });
      codigoController.clear();
      porcentajeController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor ingresa un código válido y un porcentaje de descuento.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Código de Descuento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codigoController,
              decoration: InputDecoration(labelText: 'Código de descuento'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: porcentajeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Porcentaje de descuento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardarDescuento,
              child: Text('Guardar Código de Descuento'),
            ),
            SizedBox(height: 20),
            // Mostrar el listado de códigos de descuento
            Text(
              'Códigos de Descuento:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: descuentos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Código: ${descuentos[index]['codigo']}'),
                    subtitle: Text('Descuento: ${descuentos[index]['descuento']}%'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          descuentos.removeAt(index); // Eliminar el descuento
                        });
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
