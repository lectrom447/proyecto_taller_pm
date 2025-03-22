import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/state/app_state.dart'; // Importa Firebase Firestore

class AddProductPage extends StatefulWidget {
  final Function(Product)? onProductAdded;

  AddProductPage({this.onProductAdded});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();

  // Instancia de Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _productPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final productName = _productNameController.text;
                final productPrice = double.tryParse(
                  _productPriceController.text,
                );

                if (productName.isNotEmpty && productPrice != null) {
                  // Crea el producto
                  Product newProduct = Product(
                    name: productName,
                    price: productPrice,
                    quantity: 0,
                    workshopId:
                        appState
                            .currentProfile!
                            .workshopId!, // Valor predeterminado de la cantidad
                  );

                  // Guardar en Firestore
                  await _addProductToFirestore(newProduct);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                  // Llamar al callback para informar que el producto fue agregado
                  if (widget.onProductAdded != null) {
                    widget.onProductAdded!(newProduct);
                  }
                } else {
                  // Mostrar un mensaje si falta algún campo
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please fill all fields correctly."),
                    ),
                  );
                }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  // Función para agregar el producto a Firestore
  Future<void> _addProductToFirestore(Product product) async {
    try {
      await _firestore.collection('products').add({
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
        'workshopId': product.workshopId,
      });
      print("Product added to Firestore");
    } catch (e) {
      print("Error adding product: $e");
    }
  }
}
