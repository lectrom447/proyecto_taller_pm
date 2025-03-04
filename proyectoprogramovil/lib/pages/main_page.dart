import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/pages/pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _activeIndex = 0;

  void _handleDestinationChange(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          [
            HomePage(),
            CustomersPage(),
            ServicesPage(),
            ProfilePage(),
          ][_activeIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activeIndex,
        onDestinationSelected: _handleDestinationChange,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt),
            label: 'Customers',
          ),
          NavigationDestination(
            icon: Icon(Icons.car_repair_outlined),
            selectedIcon: Icon(Icons.car_repair),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_4_outlined),
            selectedIcon: Icon(Icons.person_4),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
