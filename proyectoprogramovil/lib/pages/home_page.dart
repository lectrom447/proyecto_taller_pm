import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/home_page/customers_appbar.dart';
import 'package:proyectoprogramovil/components/home_page/home_appbar.dart';
import 'package:proyectoprogramovil/components/home_page/profile_appbar.dart';
import 'package:proyectoprogramovil/components/home_page/services_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 0;

  void _handleDestinationChange(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          <PreferredSizeWidget>[
            HomeAppbar(),
            CustomersAppbar(),
            ServicesAppbar(),

            ProfileAppbar(),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   // backgroundColor: Colors.white,
      //   // unselectedItemColor: Colors.white,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Hola'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Hola'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Hola'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Hola'),
      //   ],
      // ),
    );
  }
}
