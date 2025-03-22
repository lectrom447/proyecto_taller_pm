import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoprogramovil/models/service.dart';

class Invoice {
  final String invoiceId;  // Identificador único de la factura
  final String customerId;  // Identificador del cliente
  final String customerName;  // Nombre del cliente
  final String customerEmail;  // Correo del cliente
  final String customerPhone;  // Teléfono del cliente
  final String vehicleId;  // Identificador del vehículo
  final String vehicleModel;  // Modelo del vehículo
  final String vehiclePlate;  // Placa del vehículo
  final List<Service> services;  // Lista de servicios realizados
  final DateTime invoiceDate;  // Fecha de la factura
  final String status;  // Estado de la factura (ej. "Pagada", "Pendiente")

  // Constructor
  Invoice({
    required this.invoiceId,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.vehicleId,
    required this.vehicleModel,
    required this.vehiclePlate,
    required this.services,
    required this.invoiceDate,
    required this.status,
  });

  // Getter para calcular el totalAmount sumando los costos de los servicios
  // double get totalAmount {
  //   return services.fold(0.0, (add, service) => sum + service.cost);
  // }

  // Método para convertir la factura a un mapa (útil para guardarla en Firestore o base de datos)
  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'customerId': customerId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'vehicleId': vehicleId,
      'vehicleModel': vehicleModel,
      'vehiclePlate': vehiclePlate,
      'services': services.map((service) => service.toMap()).toList(),
      'invoiceDate': invoiceDate,
      'status': status,
    };
  }

  // Método para crear la factura a partir de un mapa (útil para leer desde Firestore o base de datos)
  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      invoiceId: map['invoiceId'],
      customerId: map['customerId'],
      customerName: map['customerName'],
      customerEmail: map['customerEmail'],
      customerPhone: map['customerPhone'],
      vehicleId: map['vehicleId'],
      vehicleModel: map['vehicleModel'],
      vehiclePlate: map['vehiclePlate'],
      services: List<Service>.from(map['services'].map((x) => Service.fromMap(x))),
      invoiceDate: (map['invoiceDate'] as Timestamp).toDate(),
      status: map['status'],
    );
  }
}

