import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/models.dart';

class Service {
  String? id;
  String? description;
  double? laborCost; // Labor cost (mano de obra)
  Timestamp? serviceDate;
  String? status;
  String? vehicleId;
  List<Product>? products;
  double? total; // Array of products

  Service({
    this.id,
    this.description,
    this.laborCost,
    this.serviceDate,
    this.status,
    this.vehicleId,
    this.products,
    this.total,
  });

  factory Service.fromMap(Map<String, dynamic> data) {
    return Service(
      id: data['id'],
      description: data['description'],
      laborCost: data['laborCost']?.toDouble(),
      serviceDate: data['serviceDate'],
      status: data['status'],
      vehicleId: data['vehicleId'],
      products:
          (data['products'] as List<dynamic>?)
              ?.map((productData) => Product.fromMap(productData))
              .toList(),
      total: data['total']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      if (description != null) "description": description,
      if (laborCost != null) "laborCost": laborCost,
      if (serviceDate != null) "serviceDate": serviceDate,
      if (status != null) "status": status,
      if (vehicleId != null) "vehicleId": vehicleId,
      if (products != null)
        "products": products?.map((product) => product.toMap()).toList(),
      if (total != null) "total": total,
    };
  }

 
}
