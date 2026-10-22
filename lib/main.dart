import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PantallaHeladas()));

class PantallaHeladas extends StatelessWidget {
  const PantallaHeladas({super.key});

  @override
  Widget build(BuildContext context) {
    // Contraste ≈ 10:1 y texto de 14 sp
    const estilo = TextStyle(fontSize: 14, color: Color(0xFF424242));
    // Contraste ≈ 5.9:1; además el estado va en texto, no solo en color
    const alerta = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFF8A5A00),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Anticipa Azángaro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Expanded en vez de width fijo: sin overflow a 360 dp
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  children: [
                    const Text('Mañana', style: estilo),
                    const SizedBox(width: 12),
                    const Text('2° mínima', style: estilo),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Riesgo de helada', style: alerta),
                    ),
                    // IconButton: objetivo de 48×48 dp y nombre accesible
                    IconButton(
                      tooltip: 'Ver consejos contra la helada de mañana',
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}