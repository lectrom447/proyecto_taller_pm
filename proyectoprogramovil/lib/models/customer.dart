import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? id;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? address;
  String? workshopId;
  bool isActive;
  String? vehicleId;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Customer({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.address,
    this.workshopId,
    this.isActive = true,
    this.vehicleId,
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
      workshopId: data['workshopId'],
      email: data['email'],
      address: data['address'],
      isActive: data['isActive'],
      vehicleId: data['vehicleId'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (fullName != null) "fullName": fullName,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (workshopId != null) "workshopId": workshopId,
      if (email != null) "email": email,
      if (address != null) "address": address,
      "isActive": isActive,
      if (vehicleId != null) "vehicleId": vehicleId, 
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
    };
  }
}
