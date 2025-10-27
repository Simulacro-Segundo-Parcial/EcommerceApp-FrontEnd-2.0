import 'user.dart';

class AuthResponse {
  final String token;
  final User user;
  final DateTime? expiration;

  const AuthResponse({
    required this.token,
    required this.user,
    this.expiration,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
      expiration: json['expiration'] != null
          ? DateTime.parse(json['expiration'])
          : null,
    );
  }
}
