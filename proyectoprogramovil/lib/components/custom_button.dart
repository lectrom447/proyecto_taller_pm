import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool _isLoading;
  final void Function()? _onPressed;
  final String _text;
  final bool _expand;
  final Color? _color;

  const CustomButton({
    super.key,
    bool isLoading = false,
    bool expand = false,
    Color? color,
    void Function()? onPressed,
    required String text,
  }) : _isLoading = isLoading,
       _onPressed = onPressed,
       _text = text,
       _expand = expand,
       _color = color;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: _color),
      onPressed: (!_isLoading) ? _onPressed : null,
      child: SizedBox(
        width: (_expand) ? double.infinity : null,
        child: Center(
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
        ),
      ),
    );
  }
}
