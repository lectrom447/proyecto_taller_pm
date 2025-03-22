import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class AccessCodeRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('access_codes')
      .withConverter(
        fromFirestore: AccessCode.fromFirestore,
        toFirestore:
            (AccessCode accessCode, options) => accessCode.toFirestore(),
      );

  Future<List<AccessCode>> findAll(String workshopId) async {
    final result =
        await collectionRef.where('workshopId', isEqualTo: workshopId).get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Future<AccessCode?> findByCode(int code) async {
    final result = await collectionRef.where('code', isEqualTo: code).get();

    if (result.size == 0) {
      return null;
    }

    return result.docs[0].data();
  }

  Future create(AccessCode newAccessCode) async {
    final documentRef = collectionRef.doc();
    newAccessCode.createdAt = Timestamp.now();
    final random = Random();
    newAccessCode.code = random.nextInt(10000) + 10000;
    await documentRef.set(newAccessCode);
  }

  Future delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.delete();
  }
}
