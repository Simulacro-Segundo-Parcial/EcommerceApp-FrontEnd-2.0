import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final cart = await ApiService.getCart();
      if (mounted) setState(() => _cartItems = cart);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final item = _cartItems[index];
          return ListTile(
            title: Text(item.productName),
            subtitle: Text('Quantity: ${item.quantity} - Price: ${item.price}'),
          );
        },
      ),
    );
  }
}
