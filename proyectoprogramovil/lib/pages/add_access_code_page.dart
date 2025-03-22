import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/access_code_form.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/repositories/access_code_repository.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class AddAccessCodePage extends StatelessWidget {
  AddAccessCodePage({super.key});

  final GlobalKey<AccessCodeFormState> _accessCodeFormKey =
      GlobalKey<AccessCodeFormState>();

  final AccessCodeRepository _accessCodeRepository = AccessCodeRepository();

  _handleCreate(BuildContext context, AccessCode acessCode) async {
    _accessCodeFormKey.currentState!.setIsLoading(true);

    final appState = Provider.of<AppState>(context, listen: false);
    acessCode.workshopId = appState.currentProfile!.workshopId;
    await _accessCodeRepository.create(acessCode);
    if (!context.mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Access Code')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: AccessCodeForm(
          key: _accessCodeFormKey,
          onSubmit: (accessCode) => _handleCreate(context, accessCode),
        ),
      ),
    );
  }
}
