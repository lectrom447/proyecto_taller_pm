import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class WorkshopRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('workshops')
      .withConverter(
        fromFirestore: Workshop.fromFirestore,
        toFirestore: (Workshop workshop, options) => workshop.toFirestore(),
      );

  Future<List<Workshop>> findAll() async {
    final result = await collectionRef.get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Future<Workshop> create(Workshop newWorkshop) async {
    final documentRef = collectionRef.doc();
    newWorkshop.createdAt = Timestamp.now();
    await documentRef.set(newWorkshop);

    final docSnapshot = await documentRef.get();
    return docSnapshot.data()!;
  }

  Future update(Workshop workshop) async {
    final documentRef = collectionRef.doc(workshop.id);
    workshop.updatedAt = Timestamp.now();
    await documentRef.update(workshop.toFirestore());
  }

  Future delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.update({'isActive': false});
  }
}
