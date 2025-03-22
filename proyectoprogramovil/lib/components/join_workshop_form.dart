import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/components.dart';

class JoinWorkshopForm extends StatefulWidget {
  final void Function(int code) onSubmit;
  const JoinWorkshopForm({super.key, required this.onSubmit});

  @override
  State<JoinWorkshopForm> createState() => JoinWorkshopFormState();
}

class JoinWorkshopFormState extends State<JoinWorkshopForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late TextEditingController _codeInputController;

  void setIsLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  void initState() {
    super.initState();
    _codeInputController = TextEditingController();
  }

  @override
  void dispose() {
    _codeInputController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final code = int.parse(_codeInputController.text);

    widget.onSubmit(code);
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
              controller: _codeInputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(label: Text('Access Code')),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Access Code is required'
                          : null,
            ),

            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Join',
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
