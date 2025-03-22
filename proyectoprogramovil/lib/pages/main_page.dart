import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/pages/main_option_page.dart';
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
    final profiles = await _profileRepository.findAll(
      FirebaseAuth.instance.currentUser!.uid,
    );

    if (mounted && profiles.isNotEmpty) {
      Provider.of<AppState>(
        context,
        listen: false,
      ).setCurrentProfile(profiles[0]);
    }

    if (!mounted) return;

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
                ? NoProfileFoundPage()
                : Scaffold(
                  body: [MainOptionPage(), ProfilePage()][_activeIndex],
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
