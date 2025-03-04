import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class CustomerRepository {
  final collectionRef = FirebaseFirestore.instance
      .collection('customers')
      .withConverter(
        fromFirestore: Customer.fromFirestore,
        toFirestore: (Customer customer, options) => customer.toFirestore(),
      );

  Future<List<Customer>> findAll() async {
    final result = await collectionRef.get();
    return result.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Future create(Customer newCustomer) async {
    final documentRef = collectionRef.doc();
    newCustomer.createdAt = DateTime.now();
    await documentRef.set(newCustomer);
  }

  Future update(Customer customer) async {
    final documentRef = collectionRef.doc(customer.id);
    customer.updatedAt = DateTime.now();
    await documentRef.update(customer.toFirestore());
  }

  Future delete(String id) async {
    final documentRef = collectionRef.doc(id);
    await documentRef.update({'isActive': false});
  }
}
