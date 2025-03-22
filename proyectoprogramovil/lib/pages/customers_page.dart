import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/repositories/repositories.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final CustomerRepository _customerRepository = CustomerRepository();
  late final AppState _appState;
  bool _isLoading = true;

  List<Customer> _customers = [];

  void _handleCreate() async {
    final isCompleted = await Navigator.pushNamed(context, 'add_customer');

    if (isCompleted != true) return;

    _loadData();
  }

  Future<void> _loadData() async {
    final customers = await _customerRepository.findAll(
      _appState.currentProfile!.workshopId!,
    );
    setState(() {
      _isLoading = false;
      _customers = customers;
    });
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customers')),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreate,
        child: Icon(Icons.add),
      ),
      body:
          (_isLoading)
              ? PageLoading()
              : ListView.separated(
                separatorBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(height: 1),
                    ),

                itemCount: _customers.length,
                itemBuilder: (context, index) {
                  final customer = _customers[index];

                  return ListTile(
                    title: Text(customer.fullName!),
                    subtitle: Text(
                      'Phone: ${customer.phoneNumber} \nEmail: ${(customer.email != null && customer.email!.isNotEmpty) ? customer.email : 'Not registered'}',
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
    );
  }
}
