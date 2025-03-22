import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer.dart';
import 'service.dart';

class Vehicle {
  String? id;
  String? plateNumber;
  String? brand;
  String? model;
  String? color;
  int? year;
  String? customerId;
  Customer? customer;
  List<Service>? services;
  bool isActive;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Vehicle({
    this.id,
    this.plateNumber,
    this.brand,
    this.model,
    this.color,
    this.year,
    this.customerId,
    this.customer,
    this.services,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Vehicle(
      id: snapshot.id,
      plateNumber: data?['plateNumber'],
      brand: data?['brand'],
      model: data?['model'],
      color: data?['color'],
      year: data?['year'],
      customerId: data?['customerId'],
      services: (data?['services'] as List<dynamic>?)
          ?.map((serviceData) => Service.fromMap(serviceData))
          .toList(),
      isActive: data?['isActive'] ?? true,
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (plateNumber != null) "plateNumber": plateNumber,
      if (brand != null) "brand": brand,
      if (model != null) "model": model,
      if (color != null) "color": color,
      if (year != null) "year": year,
      if (customerId != null) "customerId": customerId,
      if (services != null)
        "services": services!.map((service) => service.toMap()).toList(),
      "isActive": isActive,
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
    };
  }
}
