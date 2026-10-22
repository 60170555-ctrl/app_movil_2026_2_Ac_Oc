@'
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CatalogoDefectuoso()));

class CatalogoDefectuoso extends StatelessWidget {
  const CatalogoDefectuoso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vilca Market')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 380,
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Row(
                children: [
                  const Text('Arroz 1 kg',
                      style: TextStyle(fontSize: 11, color: Color(0xFFBDBDBD))),
                  const SizedBox(width: 20),
                  const Text('S/ 4.80',
                      style: TextStyle(fontSize: 11, color: Color(0xFFBDBDBD))),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.add, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
'@ | Set-Content -Encoding utf8 lib/main.dart