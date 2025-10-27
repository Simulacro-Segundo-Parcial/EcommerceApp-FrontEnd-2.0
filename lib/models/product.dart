class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String status;
  final int companyId;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.status,
    required this.companyId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      status: json['status'],
      companyId: json['companyId'],
    );
  }
}