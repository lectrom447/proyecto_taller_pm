import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/models/models.dart';

class AppState extends ChangeNotifier {
  Profile? _currentProfile;

  Profile? get currentProfile => _currentProfile;

  void setCurrentProfile(Profile newProfile) {
    _currentProfile = newProfile;
    notifyListeners(); // Notifica a los widgets dependientes
  }

  void cleanCurrentProfile() {
    _currentProfile = null;
  }
}
