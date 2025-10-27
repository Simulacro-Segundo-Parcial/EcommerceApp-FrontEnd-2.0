class User {
  final int id;
  final String email;
  final String fullName;
  final String role;
  final bool isActive;
  final int? companyId;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.isActive,
    this.companyId,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'] ?? 'Unknown', // API siempre devuelve string
      isActive: json['isActive'],
      companyId: json['companyId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
