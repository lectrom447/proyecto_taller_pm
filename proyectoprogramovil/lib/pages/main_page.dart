import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/pages/pages.dart';
import 'package:proyectoprogramovil/repositories/repositories.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _activeIndex = 0;
  final ProfileRepository _profileRepository = ProfileRepository();
  bool _loadingProfileData = true;

  void _handleDestinationChange(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkProfile();
  }

  Future _checkProfile() async {
    print(FirebaseAuth.instance.currentUser);
    final profiles = await _profileRepository.findAll(
      FirebaseAuth.instance.currentUser!.uid,
    );

    if (mounted && profiles.isNotEmpty) {
      Provider.of<AppState>(
        context,
        listen: false,
      ).setCurrentProfile(profiles[0]);
    }

    setState(() {
      _loadingProfileData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loadingProfileData
        ? Scaffold(body: PageLoading())
        : Consumer<AppState>(
          builder: (context, appState, child) {
            return (appState.currentProfile == null)
                // ? Scaffold(body: Text('No Hay Pefil'))
                ? HomePage()
                : Scaffold(
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
                      if (appState.currentProfile!.role == 'cashier')
                        NavigationDestination(
                          icon: Icon(Icons.receipt),
                          selectedIcon: Icon(Icons.home),
                          label: 'Bills',
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
          },
        );
  }
}
