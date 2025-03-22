
class Product {
  String? id;
  String? name;
  double? price;
  int? quantity;

  Product({
    this.id,
    this.name,
    this.price,
    this.quantity,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      price: data['price']?.toDouble(),
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (quantity != null) "quantity": quantity,
    };
  }
}
