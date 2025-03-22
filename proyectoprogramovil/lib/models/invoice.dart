import 'package:cloud_firestore/cloud_firestore.dart';


class Invoice {
  final String invoiceId;  // Identificador único de la factura
  final String vehicleId;  // Identificador del vehículo // Lista de servicios realizados
  final DateTime invoiceDate;  // Fecha de la factura
  final double totalAmount;  // Total de los servicios
  final bool isPaid;

  // Constructor
  Invoice({
    required this.invoiceId,
    required this.vehicleId,
    required this.invoiceDate,
    required this.totalAmount,
    required this.isPaid,
  });


  // Método para convertir la factura a un mapa (útil para guardarla en Firestore o base de datos)
  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'vehicleId': vehicleId,
      'invoiceDate': invoiceDate,
      'totalAmount': totalAmount,
       'isPaid': isPaid,
    };
  }

  // Método para crear la factura a partir de un mapa (útil para leer desde Firestore o base de datos)
  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      invoiceId: map['invoiceId'],
      vehicleId: map['vehicleId'],
      invoiceDate: (map['invoiceDate'] as Timestamp).toDate(),
      totalAmount: map['totalAmount'],
      isPaid: map['isPaid'],
    );
  }
}

