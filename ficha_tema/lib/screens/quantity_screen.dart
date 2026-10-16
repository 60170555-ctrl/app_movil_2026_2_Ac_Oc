import 'package:flutter/material.dart';

import '../widgets/quantity_selector.dart';

class QuantityScreen extends StatefulWidget {
  const QuantityScreen({super.key});

  @override
  State<QuantityScreen> createState() => _QuantityScreenState();
}

class _QuantityScreenState extends State<QuantityScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar cantidad')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Cuantas unidades deseas?'),
              const SizedBox(height: 20),
              QuantitySelector(
                value: _quantity,
                onChanged: (nueva) => setState(() => _quantity = nueva),
                min: 1,
                max: 20,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop<int>(context, _quantity),
                  child: const Text('Confirmar'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop<int>(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}