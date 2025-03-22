import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  String? id;
  String? description;
  double? cost;
  Timestamp? serviceDate;
  String? status;
  String? vehicleId;

  Service({
    this.id,
    this.description,
    this.cost,
    this.serviceDate,
    this.status,
    this.vehicleId,
  });

  factory Service.fromMap(Map<String, dynamic> data) {
    return Service(
      id: data['id'],
      description: data['description'],
      cost: data['cost']?.toDouble(),
      serviceDate: data['serviceDate'],
      status: data['status'],
      vehicleId: data['vehicleId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      if (description != null) "description": description,
      if (cost != null) "cost": cost,
      if (serviceDate != null) "serviceDate": serviceDate,
      if (status != null) "status": status,
      if (vehicleId != null) "vehicleId": vehicleId,
    };
  }
}
