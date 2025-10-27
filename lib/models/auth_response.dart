import 'user.dart'; // Importa User desde el archivo separado

class AuthResponse {
  final String token;
  final User user;
  final String? expiration;

  const AuthResponse({
    required this.token,
    required this.user,
    this.expiration,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
      expiration: json['expiration'],
    );
  }
}