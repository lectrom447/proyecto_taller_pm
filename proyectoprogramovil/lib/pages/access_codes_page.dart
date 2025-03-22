import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoprogramovil/components/components.dart';
import 'package:proyectoprogramovil/models/models.dart';
import 'package:proyectoprogramovil/repositories/access_code_repository.dart';
import 'package:proyectoprogramovil/state/app_state.dart';

class AccessCodesPage extends StatefulWidget {
  const AccessCodesPage({super.key});

  @override
  State<AccessCodesPage> createState() => _AccessCodesPageState();
}

class _AccessCodesPageState extends State<AccessCodesPage> {
  final AccessCodeRepository _accessCodeRepository = AccessCodeRepository();
  late final AppState _appState;
  bool _isLoading = true;

  List<AccessCode> _accessCodes = [];

  void _handleCreate() async {
    final isCompleted = await Navigator.pushNamed(context, 'add_access_code');

    if (isCompleted != true) return;

    _loadData();
  }

  Future<void> _loadData() async {
    final accessCodes = await _accessCodeRepository.findAll(
      _appState.currentProfile!.workshopId!,
    );
    setState(() {
      _isLoading = false;
      _accessCodes = accessCodes;
    });
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Access Codes')),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreate,
        child: Icon(Icons.add),
      ),
      body:
          (_isLoading)
              ? PageLoading()
              : ListView.separated(
                separatorBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(height: 1),
                    ),

                itemCount: _accessCodes.length,
                itemBuilder: (context, index) {
                  final acessCode = _accessCodes[index];

                  return ListTile(
                    title: Text(acessCode.code!.toString()),
                    subtitle: Text('Role: ${acessCode.role}'),
                  );
                },
              ),
    );
  }
}
