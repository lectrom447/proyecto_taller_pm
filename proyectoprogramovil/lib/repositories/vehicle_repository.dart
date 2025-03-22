import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class VehicleRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('vehicles')
      .withConverter(
        fromFirestore: Vehicle.fromFirestore,
        toFirestore: (Vehicle vehicle, options) => vehicle.toFirestore(),
      );

  // Fetch all vehicles by customer ID
  Future<List<Vehicle>> findAllByCustomer(String customerId) async {
    final result =
        await collectionRef
            .where('customerId', isEqualTo: customerId)
            .where('isActive', isEqualTo: true)
            .get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  // Create a new vehicle
  Future<void> create(Vehicle newVehicle) async {
    final documentRef = collectionRef.doc();
    newVehicle.createdAt = Timestamp.now();
    newVehicle.updatedAt =
        Timestamp.now(); // Ensure `updatedAt` is set on creation
    await documentRef.set(newVehicle);
  }

  // Update an existing vehicle
  Future<void> update(Vehicle vehicle) async {
    final documentRef = collectionRef.doc(vehicle.id);
    vehicle.updatedAt = Timestamp.now(); // Set updatedAt on every update
    await documentRef.update(vehicle.toFirestore());
  }

  // Soft delete a vehicle (mark it as inactive)
  Future<void> delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.update({'isActive': false});
  }
}
