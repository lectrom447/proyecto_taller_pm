import 'package:flutter/material.dart';

class CustomersAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomersAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Customers'));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
