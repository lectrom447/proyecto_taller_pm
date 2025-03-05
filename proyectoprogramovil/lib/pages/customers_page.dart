import 'package:flutter/material.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  void _handleCreate() {
    Navigator.pushNamed(context, 'add_customer');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customers')),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreate,
        child: Icon(Icons.add),
      ),
    );
  }
}
