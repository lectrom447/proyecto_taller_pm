import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool _isLoading;
  final void Function()? _onPressed;
  final String _text;
  const CustomButton({
    super.key,
    bool isLoading = false,
    void Function()? onPressed,
    required String text,
  }) : _isLoading = isLoading,
       _onPressed = onPressed,
       _text = text;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: (!_isLoading) ? _onPressed : null,
      child:
          (!_isLoading)
              ? Text(_text)
              : SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
    );
  }
}
