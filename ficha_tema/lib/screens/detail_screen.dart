import 'package:flutter/material.dart';

import '../models/product_args.dart';
import '../routes/app_routes.dart';
import '../widgets/section_title.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.args});

  final ProductArgs args;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _quantity = 1;

  Future<void> _chooseQuantity() async {
    final int? result =
        await Navigator.pushNamed<int>(context, AppRoutes.quantity);

    // ⚠️ ERROR 5 INTENCIONAL: falta "if (!mounted) return;"
    // flutter analyze marcara: use_build_context_synchronously

    if (result != null) {
      setState(() => _quantity = result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cantidad actualizada: $result')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final producto = widget.args;
    final total = producto.price * _quantity;

    return Scaffold(
      appBar: AppBar(title: Text(producto.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.inventory_2_outlined, size: 88),
          const SizedBox(height: 20),
          Text(
            producto.name,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Center(child: SectionTitle('Descripcion del producto')),
          const SizedBox(height: 8),
          Text(producto.description, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _dato('Precio unitario',
                      'S/ ${producto.price.toStringAsFixed(2)}'),
                  const Divider(height: 24),
                  _dato('Cantidad seleccionada', '$_quantity'),
                  const Divider(height: 24),
                  _dato('Total', 'S/ ${total.toStringAsFixed(2)}',
                      destacado: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _chooseQuantity,
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Elegir cantidad'),
          ),
        ],
      ),
    );
  }

  Widget _dato(String titulo, String valor, {bool destacado = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(titulo)),
        const SizedBox(width: 12),
        Text(
          valor,
          style: TextStyle(
            fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
            fontSize: destacado ? 18 : 16,
          ),
        ),
      ],
    );
  }
}