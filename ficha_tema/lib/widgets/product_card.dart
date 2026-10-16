import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.onTap,
  });

  final String name;
  final double price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.shopping_basket_outlined),
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('S/ ${price.toStringAsFixed(2)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}