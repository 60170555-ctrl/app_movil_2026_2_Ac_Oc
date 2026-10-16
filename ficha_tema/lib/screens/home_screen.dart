import 'package:flutter/material.dart';

import '../models/product_args.dart';
import '../routes/app_routes.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<ProductArgs> productos = [
    ProductArgs(
      name: 'Quinua organica 1 kg',
      price: 12.50,
      description: 'Quinua del altiplano puneno.',
    ),
    ProductArgs(
      name: 'Chuno blanco 500 g',
      price: 9.00,
      description: 'Chuno blanco de produccion local.',
    ),
    ProductArgs(
      name: 'Queso paria 250 g',
      price: 11.00,
      description: 'Queso paria artesanal.',
    ),
    ProductArgs(
      name: 'Miel de abeja 350 ml',
      price: 18.00,
      description: 'Miel de abeja pura.',
    ),
  ];

  void _abrirDetalle(BuildContext context, ProductArgs producto) {
    Navigator.pushNamed(context, AppRoutes.detail, arguments: producto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vilca Market')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle('Productos de la region'),
          const SizedBox(height: 8),
          for (final producto in productos)
            ProductCard(
              name: producto.name,
              price: producto.price,
              onTap: () => _abrirDetalle(context, producto),
            ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
            icon: const Icon(Icons.person_add_alt_1),
            label: const Text('Ir al registro'),
          ),
        ],
      ),
    );
  }
}