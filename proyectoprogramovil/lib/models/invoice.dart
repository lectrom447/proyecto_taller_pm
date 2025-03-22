import 'package:cloud_firestore/cloud_firestore.dart';


class Invoice {
  final String invoiceId;  // Identificador único de la factura
  final String customerId;  // Identificador del cliente
  final String vehicleId;  // Identificador del vehículo // Lista de servicios realizados
  final DateTime invoiceDate;  // Fecha de la factura
  final String status;  // Estado de la factura (ej. "Pagada", "Pendiente")
  final double totalAmount;  // Total de los servicios

  // Constructor
  Invoice({
    required this.invoiceId,
    required this.customerId,
    required this.vehicleId,
    required this.invoiceDate,
    required this.status,
    required this.totalAmount,
  });


  // Método para convertir la factura a un mapa (útil para guardarla en Firestore o base de datos)
  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'customerId': customerId,
      'vehicleId': vehicleId,
      'invoiceDate': invoiceDate,
      'status': status,
      'totalAmount': totalAmount,
    };
  }

  // Método para crear la factura a partir de un mapa (útil para leer desde Firestore o base de datos)
  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      invoiceId: map['invoiceId'],
      customerId: map['customerId'],
      vehicleId: map['vehicleId'],
      invoiceDate: (map['invoiceDate'] as Timestamp).toDate(),
      status: map['status'],
      totalAmount: map['totalAmount'],
    );
  }
}

