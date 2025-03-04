import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? id;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? address;
  bool isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customer({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.address,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Customer(
      id: snapshot.id,
      fullName: data!['fullName'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      address: data['address'],
      isActive: data['isActive'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (fullName != null) "fullName": fullName,
      if (phoneNumber != null) "state": phoneNumber,
      if (email != null) "email": email,
      if (address != null) "address": address,
      "population": isActive,
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
    };
  }
}
