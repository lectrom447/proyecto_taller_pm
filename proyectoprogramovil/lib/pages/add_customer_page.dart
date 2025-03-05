import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/repositories/repositories.dart';

class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

  final GlobalKey<CustomerFormState> _customerFormKey =
      GlobalKey<CustomerFormState>();

  final CustomerRepository _customerRepository = CustomerRepository();

  _handleCreate(BuildContext context, Customer customer) async {
    _customerFormKey.currentState!.setIsLoading(true);
    await _customerRepository.create(customer);
    if (!context.mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Customer')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: CustomerForm(
          key: _customerFormKey,
          onSubmit: (customer) => _handleCreate(context, customer),
        ),
      ),
    );
  }
}
