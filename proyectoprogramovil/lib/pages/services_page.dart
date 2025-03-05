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
        title: Text(
          'Services',
          // style: TextStyle(fontSize: 25, color: Colors.grey.shade800),
          // style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        bottom: TabBar(
          onTap: (_) => setState(() {}),
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.white,
          // labelColor: Colors.blue.shade500,
          // indicatorColor: Colors.blue.shade500,
          // unselectedLabelColor: Colors.grey.shade800,
          controller: _tabController,
          tabs: [Tab(text: 'In Process'), Tab(text: 'Completed')],
        ),
      ),

      floatingActionButton:
          (_tabController.index == 0)
              ? FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
                child: Icon(Icons.add),
              )
              : null,
    );
  }
}
