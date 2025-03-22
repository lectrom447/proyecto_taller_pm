import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class CustomerRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('customers')
      .withConverter(
        fromFirestore: Customer.fromFirestore,
        toFirestore: (Customer customer, options) => customer.toFirestore(),
      );

  Future<List<Customer>> findAll(String workshopId) async {
    final result =
        await collectionRef.where('workshopId', isEqualTo: workshopId).get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Future<Customer?> findById(String id) async {
    final docSnapshot = await collectionRef.doc(id).get();
    if (docSnapshot.exists) {
      return docSnapshot.data();
    } else {
      return null; // Si no existe el cliente, retornamos null
    }
  }

  Future create(Customer newCustomer) async {
    final documentRef = collectionRef.doc();
    newCustomer.createdAt = Timestamp.now();
    await documentRef.set(newCustomer);
  }

  Future update(Customer customer) async {
    final documentRef = collectionRef.doc(customer.id);
    customer.updatedAt = Timestamp.now();
    await documentRef.update(customer.toFirestore());
  }

  Future delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.update({'isActive': false});
  }
}
