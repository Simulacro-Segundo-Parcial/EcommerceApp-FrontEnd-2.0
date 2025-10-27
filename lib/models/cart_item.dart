class CartItem {
  final int productId;
  final String productName;
  final int quantity;
  final double price;
  final DateTime addedAt;

  const CartItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.addedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      addedAt: DateTime.parse(json['addedAt']),
    );
  }
}
