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

  Future<Vehicle?> getById(String vehicleId) async {
    try {
      // Obtener los documentos que coinciden con el vehicleId
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('vehicles') // Colección de vehículos
              .where('id', isEqualTo: vehicleId) // Filtrar por 'id'
              .get();

      // Verifica si se encontraron documentos
      if (querySnapshot.docs.isEmpty) {
        return null; // No se encuentra el vehículo
      }

      // Obtener el primer documento (asumimos que hay solo uno con este vehicleId)
      final documentSnapshot = querySnapshot.docs.first;
      final data = documentSnapshot.data(); // Obtener los datos del documento

      // Convertir manualmente los datos a un objeto Vehicle
      Vehicle vehicle = Vehicle(
        id: documentSnapshot.id,
        plateNumber: data['plateNumber'],
        brand: data['brand'],
        model: data['model'],
        color: data['color'],
        year: data['year'],
        customerId: data['customerId'],
        isActive: data['isActive'] ?? true,
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );

      // Convertir la lista de servicios si está presente
      if (data['services'] != null) {
        vehicle.services =
            (data['services'] as List<dynamic>)
                .map((serviceData) => Service.fromMap(serviceData))
                .toList();
      }

      return vehicle; // Retornar el vehículo
    } catch (e) {
      print('Error al obtener vehículo: $e');
      return null; // Devuelve null en caso de error
    }
  }

  // Create a new vehicle
  Future<Vehicle> create(Vehicle newVehicle) async {
    final documentRef = collectionRef.doc();
    newVehicle.createdAt = Timestamp.now();
    newVehicle.updatedAt =
        Timestamp.now(); // Ensure `updatedAt` is set on creation
    newVehicle.id = documentRef.id;
    await documentRef.set(newVehicle);
    return newVehicle;
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
