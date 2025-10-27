class CartItem {
  final int productId;
  final String productName;
  final int quantity;
  final double price;

  const CartItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
