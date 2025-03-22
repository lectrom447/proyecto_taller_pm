import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Descuentos'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('discounts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay descuentos disponibles.'));
          }

          final discounts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: discounts.length,
            itemBuilder: (context, index) {
              final discount = discounts[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: Icon(
                    Icons.local_offer,
                    color: Colors.green,
                    size: 40,
                  ),
                  title: Text(
                    discount['codeName'] ?? 'Descuento sin título',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Descuento: ${discount['amount'] ?? '0'}%',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
