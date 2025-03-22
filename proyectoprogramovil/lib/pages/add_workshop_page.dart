import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/repositories/repositories.dart';

class AddWorkshopPage extends StatelessWidget {
  AddWorkshopPage({super.key});

  final GlobalKey<WorkshopFormState> _workshopFormKey =
      GlobalKey<WorkshopFormState>();

  final WorkshopRepository _workshopRepository = WorkshopRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  _handleCreate(BuildContext context, Workshop workshop) async {
    _workshopFormKey.currentState!.setIsLoading(true);
    final createdWorkshop = await _workshopRepository.create(workshop);
    final newProfile = Profile(
      role: 'admin',
      userId: FirebaseAuth.instance.currentUser!.uid,
      workshopId: createdWorkshop.id,
    );

    await _profileRepository.create(newProfile);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Workshop')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: WorkshopForm(
          key: _workshopFormKey,
          onSubmit: (workshop) => _handleCreate(context, workshop),
        ),
      ),
    );
  }
}
