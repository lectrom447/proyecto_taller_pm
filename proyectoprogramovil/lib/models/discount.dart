class Discount {
  final double amount; // The discount amount (could be percentage or fixed)
  final String codeName; // Unique code for the discount

  // Constructor to initialize the discount
  Discount({
    required this.amount,
    required this.codeName,
  });

  // Convert a Discount object into a Map for storing it in Firestore
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'codeName': codeName,
    };
  }

  // Convert a Map from Firestore into a Discount object
  factory Discount.fromMap(Map<String, dynamic> map) {
    return Discount(
      amount: map['amount'] ?? 0.0,
      codeName: map['codeName'] ?? '',
    );
  }
}
