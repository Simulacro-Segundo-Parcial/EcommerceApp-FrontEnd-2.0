class User {
  final int id;
  final String email;
  final String fullName;
  final String role;
  final int? companyId;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.companyId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Manejar role numérico o string
    String roleValue;
    if (json['role'] is int) {
      switch (json['role']) {
        case 0:
          roleValue = 'Admin';
          break;
        case 1:
          roleValue = 'CompanyAdmin';
          break;
        case 2:
          roleValue = 'Customer';
          break;
        default:
          roleValue = 'Unknown';
      }
    } else {
      roleValue = json['role'] ?? 'Unknown';
    }

    return User(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      role: roleValue,
      companyId: json['companyId'],
    );
  }
}