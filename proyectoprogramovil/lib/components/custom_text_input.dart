import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String? label;

  const CustomTextInput({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        label: (label != null) ? Text(label!) : null,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(12)),
        // ),
      ),
    );
  }
}
