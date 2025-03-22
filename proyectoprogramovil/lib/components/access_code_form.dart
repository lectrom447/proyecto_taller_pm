import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';

class AccessCodeForm extends StatefulWidget {
  final void Function(AccessCode accessCode) onSubmit;
  const AccessCodeForm({super.key, required this.onSubmit});

  @override
  State<AccessCodeForm> createState() => AccessCodeFormState();
}

class AccessCodeFormState extends State<AccessCodeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String? _selectedRole;

  void _handleRoleChange(String? value) {
    setState(() {
      _selectedRole = value;
    });
  }

  void setIsLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final accessCode = AccessCode(role: _selectedRole);
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select a role'), backgroundColor: Colors.red),
      );

      return;
    }
    widget.onSubmit(accessCode);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            DropdownButton<String>(
              hint: Text('Select a role'),
              value: _selectedRole,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),

              items: [
                DropdownMenuItem(value: 'cashier', child: Text('Cashier')),
                DropdownMenuItem(value: 'technique', child: Text('Technique')),
              ],
              onChanged: _handleRoleChange,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Save',
                isLoading: _isLoading,
                onPressed: _handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
