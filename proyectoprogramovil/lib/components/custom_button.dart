import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool _isLoading;
  final void Function()? _onPressed;
  const CustomButton({
    super.key,
    bool isLoading = false,
    void Function()? onPressed,
  }) : _isLoading = isLoading,
       _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: (!_isLoading) ? _onPressed : null,
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
    );
  }
}
