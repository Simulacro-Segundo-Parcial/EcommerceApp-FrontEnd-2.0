class Company {
  final int id;
  final String name;
  final String description;
  final String industry;
  final String status;

  const Company({
    required this.id,
    required this.name,
    required this.description,
    required this.industry,
    required this.status,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      industry: json['industry'],
      status: json['status'],
    );
  }
}