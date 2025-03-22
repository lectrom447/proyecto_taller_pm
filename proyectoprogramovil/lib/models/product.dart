class Product {
  String? id;
  String? name;
  double? price;
  int? quantity;
  String? workshopId;

  Product({this.id, this.name, this.price, this.quantity, this.workshopId});

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      price: data['price']?.toDouble(),
      quantity: data['quantity'],
      workshopId: data['workshopId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (quantity != null) "quantity": quantity,
      if (workshopId != null) "workshopId": workshopId,
    };
  }
}
