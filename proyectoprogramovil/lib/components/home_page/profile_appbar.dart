import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Profile'));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
