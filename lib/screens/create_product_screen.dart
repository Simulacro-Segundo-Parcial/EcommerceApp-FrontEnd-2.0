import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController(text: '0'); // stock por defecto
  final _statusController = TextEditingController(text: 'active'); // status por defecto
  final _companyIdController = TextEditingController(text: '1'); // companyId por defecto

  bool _isLoading = false;

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ApiService.createProduct(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        status: _statusController.text.trim(),
        companyId: int.parse(_companyIdController.text),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto creado exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear producto: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Producto'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Agrega un nuevo producto para vender',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Nombre del producto
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del producto',
                      prefixIcon: const Icon(Icons.label),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Ingresa un nombre válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Descripción
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Agrega una descripción';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Precio
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa un precio';
                      }
                      final price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'El precio debe ser mayor que 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Stock
                  TextFormField(
                    controller: _stockController,
                    decoration: InputDecoration(
                      labelText: 'Stock',
                      prefixIcon: const Icon(Icons.inventory),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa stock';
                      final stock = int.tryParse(value);
                      if (stock == null || stock < 0) return 'Stock inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Status
                  TextFormField(
                    controller: _statusController,
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      prefixIcon: const Icon(Icons.info),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa estado';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // CompanyId
                  TextFormField(
                    controller: _companyIdController,
                    decoration: InputDecoration(
                      labelText: 'ID de la empresa',
                      prefixIcon: const Icon(Icons.business),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa ID de empresa';
                      final id = int.tryParse(value);
                      if (id == null || id <= 0) return 'ID inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Botón guardar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _saveProduct,
                      icon: const Icon(Icons.save),
                      label: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Guardar Producto'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cancelar
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
