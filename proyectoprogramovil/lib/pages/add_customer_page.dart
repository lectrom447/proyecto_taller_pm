import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/components.dart';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Customer')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(label: Text('Full Name')),
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(label: Text('Phone Number')),
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('Email')),
              ),
              SizedBox(height: 30),
              TextFormField(
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(label: Text('Address')),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: () {}, child: Text('Save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
