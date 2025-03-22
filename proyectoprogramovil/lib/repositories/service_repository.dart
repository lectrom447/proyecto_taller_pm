import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class ServiceRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('services')
      .withConverter(
        fromFirestore: (snapshot, _) => Service.fromMap(snapshot.data()!),
        toFirestore: (Service service, _) => service.toMap(),
      );

  Future<List<Service>> findAllByVehicle(String vehicleId) async {
    final result =
        await collectionRef.where('vehicleId', isEqualTo: vehicleId).get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Future create(Service newService) async {
    final documentRef = collectionRef.doc();
    newService.serviceDate = Timestamp.now();
    await documentRef.set(newService);
  }

  Future update(Service service) async {
    final documentRef = collectionRef.doc(service.id);
    await documentRef.update(service.toMap());
  }

  Future delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.delete();
  }
}
