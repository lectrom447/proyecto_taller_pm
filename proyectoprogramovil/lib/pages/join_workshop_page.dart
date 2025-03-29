import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectoprogramovil/components/join_workshop_form.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/repositories/access_code_repository.dart';
import 'package:proyectoprogramovil/repositories/profile_repository.dart';

class JoinWorkshopPage extends StatelessWidget {
  JoinWorkshopPage({super.key});

  final GlobalKey<JoinWorkshopFormState> _joinWorkshopFormKey =
      GlobalKey<JoinWorkshopFormState>();

  final AccessCodeRepository _accessCodeRepository = AccessCodeRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  _handleCreate(BuildContext context, int code) async {
    _joinWorkshopFormKey.currentState!.setIsLoading(true);

    // final appState = Provider.of<AppState>(context, listen: false);

    final result = await _accessCodeRepository.findByCode(code);

    if (context.mounted && result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Access Code Not found'),
          backgroundColor: Colors.red,
        ),
      );

      _joinWorkshopFormKey.currentState!.setIsLoading(false);

      return;
    }

    final newProfile = Profile(
      role: result!.role,
      userId: FirebaseAuth.instance.currentUser!.uid,
      workshopId: result.workshopId,
    );

    await _profileRepository.create(newProfile);
    await _accessCodeRepository.delete(result.id!);

    if (!context.mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join to a Workshop')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: JoinWorkshopForm(
          key: _joinWorkshopFormKey,
          onSubmit: (code) => _handleCreate(context, code),
        ),
      ),
    );
  }
}
