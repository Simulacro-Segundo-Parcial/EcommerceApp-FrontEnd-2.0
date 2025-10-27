import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response.dart';
import '../models/product.dart';
import '../models/company.dart';
import '../models/cart_item.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5238';
  static String? _token;

  // Token management
  static Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    if (_token == null) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
    }
    return _token;
  }

  static Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Map<String, String> _getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Auth
  static Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: _getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);
      await setToken(authResponse.token);
      return authResponse;
    } else {
      throw Exception('Error en login: ${response.body}');
    }
  }

  static Future<AuthResponse> register(String email, String password, String fullName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: _getHeaders(),
      body: jsonEncode({'email': email, 'password': password, 'fullName': fullName}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(data);
      await setToken(authResponse.token);
      return authResponse;
    } else {
      throw Exception('Error en registro: ${response.body}');
    }
  }

  // Products
  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/products'), headers: _getHeaders());
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Error obteniendo productos: ${response.body}');
    }
  }

  static Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String status,
    required int companyId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/products'),
      headers: _getHeaders(),
      body: jsonEncode({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'status': status,
        'companyId': companyId,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Error creando producto: ${response.body}');
    }
  }

  // Companies
  static Future<List<Company>> getCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/api/companies'), headers: _getHeaders());
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Company.fromJson(e)).toList();
    } else {
      throw Exception('Error obteniendo empresas: ${response.body}');
    }
  }

  // Shopping Cart
  static Future<List<CartItem>> getCart() async {
    final response = await http.get(Uri.parse('$baseUrl/api/shoppingcart'), headers: _getHeaders());
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => CartItem.fromJson(e)).toList();
    } else {
      throw Exception('Error obteniendo carrito: ${response.body}');
    }
  }

  static Future<void> addToCart(int productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/shoppingcart/add'),
      headers: _getHeaders(),
      body: jsonEncode({'productId': productId, 'quantity': quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error agregando al carrito: ${response.body}');
    }
  }

  // Email check
  static Future<bool> checkEmailExists(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/check-email?email=$email'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'] == true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      throw Exception('Error verificando email: ${response.body}');
    }
  }
}
