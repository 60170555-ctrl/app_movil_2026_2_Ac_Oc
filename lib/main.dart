import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi primera pantalla',
      home: const MiPantalla(),
    );
  }
}

class MiPantalla extends StatelessWidget {
  const MiPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos a primera pantalla'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Hola, Anail Sorayda!',
              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 243, 60, 197)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Hola desde tu primer botón!')),
                );
              },
              child: const Text('Saludar'),
            ),
          ],
        ),
      ),
    );
  }
}