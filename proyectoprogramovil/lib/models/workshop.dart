import 'package:cloud_firestore/cloud_firestore.dart';

class Workshop {
  String? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  bool isActive;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Workshop({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Workshop.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Workshop(
      id: snapshot.id,
      name: data!['name'],
      address: data['address'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      isActive: data['isActive'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (email != null) "email": email,
      if (address != null) "address": address,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (email != null) "email": email,
      "isActive": isActive,
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
    };
  }
}
