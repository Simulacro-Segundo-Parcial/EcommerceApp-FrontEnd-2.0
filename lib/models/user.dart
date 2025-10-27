enum UserRole {
  Customer,
  Admin,
  // otros roles si existen
}

class User {
  final int id;
  final String email;
  final String fullName;
  final UserRole role;  // Ahora es un enum
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
      role: UserRole.values[json['role']], // convierte int a enum
      isActive: json['isActive'],
      companyId: json['companyId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
