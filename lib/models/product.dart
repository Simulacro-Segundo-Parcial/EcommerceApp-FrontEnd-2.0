class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String status;
  final int companyId;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime? publishedAt;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.status,
    required this.companyId,
    required this.imageUrl,
    required this.createdAt,
    this.publishedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      status: json['status'],
      companyId: json['companyId'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
    );
  }
}
