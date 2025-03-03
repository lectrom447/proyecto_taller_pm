import 'package:flutter/material.dart';

class ServicesAppbar extends StatefulWidget implements PreferredSizeWidget {
  const ServicesAppbar({super.key});

  @override
  State<ServicesAppbar> createState() => _ServicesAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _ServicesAppbarState extends State<ServicesAppbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Services'),
      bottom: TabBar(
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.white,
        controller: _tabController,
        tabs: [Tab(text: 'In Process'), Tab(text: 'Completed')],
      ),
    );
  }
}
