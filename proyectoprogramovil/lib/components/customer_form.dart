import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/models/models.dart';

class CustomerForm extends StatefulWidget {
  final void Function(Customer customer) onSubmit;
  const CustomerForm({super.key, required this.onSubmit});

  @override
  State<CustomerForm> createState() => CustomerFormState();
}

class CustomerFormState extends State<CustomerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late TextEditingController _nameInputController;
  late TextEditingController _phoneInputController;
  late TextEditingController _emailInputController;
  late TextEditingController _addressInputController;

  void setIsLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameInputController = TextEditingController();
    _phoneInputController = TextEditingController();
    _emailInputController = TextEditingController();
    _addressInputController = TextEditingController();
  }

  @override
  void dispose() {
    _nameInputController.dispose();
    _phoneInputController.dispose();
    _emailInputController.dispose();
    _addressInputController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final customer = Customer(
      fullName: _nameInputController.text,
      phoneNumber: _phoneInputController.text,
      email: _emailInputController.text,
      address: _addressInputController.text,
    );

    widget.onSubmit(customer);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              enabled: !_isLoading,
              controller: _nameInputController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(label: Text('Full Name')),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Full Name is required'
                          : null,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _phoneInputController,
              enabled: !_isLoading,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(label: Text('Phone Number')),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Phone number is required'
                          : null,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _emailInputController,
              enabled: !_isLoading,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(label: Text('Email')),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _addressInputController,
              enabled: !_isLoading,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(label: Text('Address')),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Address is required'
                          : null,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (!_isLoading) ? _handleSubmit : null,
                child:
                    (!_isLoading)
                        ? Text('Save')
                        : SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
