import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Home'));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
