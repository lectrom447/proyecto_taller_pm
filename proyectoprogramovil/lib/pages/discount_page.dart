import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/models/models.dart' show Discount;

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController porcentajeController = TextEditingController();
  List<Discount> descuentos = []; // Lista para almacenar los objetos de descuento

  void guardarDescuento() async {
    String codigo = codigoController.text.trim();
    double? porcentaje = double.tryParse(porcentajeController.text);

    if (codigo.isNotEmpty && porcentaje != null && porcentaje > 0) {
      Discount newDiscount = Discount(codeName: codigo, amount: porcentaje);

      // Add the discount to Firestore
      try {
        // Save the discount in the "discounts" collection
        await FirebaseFirestore.instance.collection('discounts').add(newDiscount.toMap());

        setState(() {
          descuentos.add(newDiscount); // Agregar el nuevo descuento a la lista local
        });

        // Clear the input fields
        codigoController.clear();
        porcentajeController.clear();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Código de descuento guardado con éxito.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el descuento: $e')),
        );
      }
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
                    title: Text('Código: ${descuentos[index].codeName}'),
                    subtitle: Text('Descuento: ${descuentos[index].amount}%'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Remove discount from local list and Firestore
                        try {
                          // Assuming you want to remove the discount from Firestore
                          var snapshot = await FirebaseFirestore.instance
                              .collection('discounts')
                              .where('codeName', isEqualTo: descuentos[index].codeName)
                              .get();
                          for (var doc in snapshot.docs) {
                            await doc.reference.delete(); // Delete the document from Firestore
                          }

                          setState(() {
                            descuentos.removeAt(index); // Remove the discount from the list
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error al eliminar el descuento: $e')),
                          );
                        }
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