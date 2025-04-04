import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/pages/customers_page.dart';
import 'package:proyectoprogramovil/repositories/vehicle_repository.dart';

class AddVehiclePage extends StatefulWidget {
  final String? customerId; // Pass the customerId when navigating to this page
  final String? workshopId; // Pass the customerId when navigating to this page

  const AddVehiclePage({
    super.key,
    required this.customerId,
    required this.workshopId,
  });

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  final VehicleRepository _vehicleRepository = VehicleRepository();

  String? _plateNumber;
  String? _brand;
  String? _model;
  String? _color;
  int? _year;
  void _saveVehicle() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      Vehicle newVehicle = Vehicle(
        workshopId: widget.workshopId,
        plateNumber: _plateNumber,
        brand: _brand,
        model: _model,
        color: _color,
        year: _year,
        customerId: widget.customerId,
        isActive: true,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      try {
        final createdVehicle = await _vehicleRepository.create(newVehicle);

        final customerRef = FirebaseFirestore.instance
            .collection('customers')
            .doc(widget.customerId);

        final customerSnapshot = await customerRef.get();

        if (customerSnapshot.exists) {
          final customerData = customerSnapshot.data() as Map<String, dynamic>;

          customerData['vehicleId'] = createdVehicle.id;

          // Now update the customer with the new vehicleId
          await customerRef.update(customerData);

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Customer updated with vehicle!')),
          );
        }

        if (!mounted) return;
        // Show success and pop the current screen
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Vehicle added successfully!')));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error adding vehicle: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Plate Number Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Plate Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the plate number';
                  }
                  return null;
                },
                onSaved: (value) => _plateNumber = value,
              ),
              SizedBox(height: 20),

              // Brand Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Brand'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand';
                  }
                  return null;
                },
                onSaved: (value) => _brand = value,
              ),
              SizedBox(height: 20),

              // Model Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
                onSaved: (value) => _model = value,
              ),
              SizedBox(height: 20),

              // Color Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Color'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the color';
                  }
                  return null;
                },
                onSaved: (value) => _color = value,
              ),
              SizedBox(height: 20),

              // Year Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  return null;
                },
                onSaved: (value) => _year = int.tryParse(value ?? ''),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _saveVehicle,
                child: Text('Save Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
