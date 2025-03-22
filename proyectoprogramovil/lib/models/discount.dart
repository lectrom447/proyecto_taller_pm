class Discount {
  final double amount; // The discount amount (could be percentage or fixed)
  final String codeName; // Unique code for the discount
  final String workshopId;

  // Constructor to initialize the discount
  Discount({
    required this.amount,
    required this.codeName,
    required this.workshopId,
  });

  // Convert a Discount object into a Map for storing it in Firestore
  Map<String, dynamic> toMap() {
    return {'amount': amount, 'codeName': codeName, 'workshopId': workshopId};
  }

  // Convert a Map from Firestore into a Discount object
  factory Discount.fromMap(Map<String, dynamic> map) {
    return Discount(
      amount: map['amount'] ?? 0.0,
      codeName: map['codeName'] ?? '',
      workshopId: map['workshopId'],
    );
  }
}
