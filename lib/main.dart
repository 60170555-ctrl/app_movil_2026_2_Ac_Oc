import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CatalogoDefectuoso()));

class CatalogoDefectuoso extends StatelessWidget {
  const CatalogoDefectuoso({super.key});

  @override
  Widget build(BuildContext context) {
    // H2 y H5: contraste ≈ 10:1 y texto de 14 sp
    const estilo = TextStyle(fontSize: 14, color: Color(0xFF424242));

    return Scaffold(
      appBar: AppBar(title: const Text('Vilca Market')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // H1: Expanded en vez de width fijo de 380 (sin overflow)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  children: [
                    const Expanded(child: Text('Arroz 1 kg', style: estilo)),
                    const SizedBox(width: 20),
                    const Text('S/ 4.80', style: estilo),
                    // H3 y H4: IconButton (48×48 dp) con nombre accesible
                    IconButton(
                      tooltip: 'Agregar Arroz 1 kg al carrito',
                      icon: const Icon(Icons.add),
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