import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/pages/add_vehicle_page.dart';
import 'package:proyectoprogramovil/repositories/repositories.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

  final GlobalKey<CustomerFormState> _customerFormKey =
      GlobalKey<CustomerFormState>();

  final CustomerRepository _customerRepository = CustomerRepository();

  _handleCreate(BuildContext context, Customer customer) async {
    _customerFormKey.currentState!.setIsLoading(true);

    final appState = Provider.of<AppState>(context, listen: false);
    customer.workshopId = appState.currentProfile!.workshopId;
    final createdCustomer = await _customerRepository.create(customer);
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddVehiclePage(customerId: createdCustomer.id),
      ),
    );
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
