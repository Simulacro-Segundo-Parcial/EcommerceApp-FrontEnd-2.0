// main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/create_product_screen.dart';
import 'screens/register_company_screen.dart';
// import 'screens/admin_screen.dart'; // Futuro: pantalla de administración

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/products': (context) => const ProductListScreen(),
        '/product_detail': (context) => const ProductDetailScreen(),
        '/cart': (context) => const CartScreen(),
        '/create_product': (context) => const CreateProductScreen(),
        '/register_company': (context) => const RegisterCompanyScreen(),
        // '/admin': (context) => const AdminScreen(), // Por implementar
      },
    );
  }
}
