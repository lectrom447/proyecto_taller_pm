import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        bottom: TabBar(
          onTap: (_) => setState(() {}),
          controller: _tabController,
          tabs: [Tab(text: 'In Process'), Tab(text: 'Completed')],
        ),
      ),

      floatingActionButton:
          (_tabController.index == 0)
              ? FloatingActionButton(onPressed: () {}, child: Icon(Icons.add))
              : null,
    );
  }
}
