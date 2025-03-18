import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';

class WorkshopForm extends StatefulWidget {
  final void Function(Workshop workshop) onSubmit;
  const WorkshopForm({super.key, required this.onSubmit});

  @override
  State<WorkshopForm> createState() => WorkshopFormState();
}

class WorkshopFormState extends State<WorkshopForm> {
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
    final workshop = Workshop(
      name: _nameInputController.text,
      phoneNumber: _phoneInputController.text,
      email: _emailInputController.text,
      address: _addressInputController.text,
    );

    widget.onSubmit(workshop);
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
              decoration: InputDecoration(label: Text('Name')),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Name is required'
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
