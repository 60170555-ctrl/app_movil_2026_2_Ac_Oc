import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO 1: el modelo
class ContadorModel extends ChangeNotifier {
  int _items = 0;
  int get items => _items;

  void agregar() {
    _items++;
    notifyListeners(); // avisa a los Consumer que deben reconstruirse
  }
}

// TODO 2: el provider envuelve a MaterialApp
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorModel(),
      child: const MaterialApp(home: PantallaCatalogo()),
    ),
  );
}

// TODO 3: ahora es StatelessWidget
class PantallaCatalogo extends StatelessWidget {
  const PantallaCatalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ContadorModel>(
          builder: (context, modelo, _) => Text('Catálogo (${modelo.items})'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Provider.of<ContadorModel>(context, listen: false).agregar(),
              child: const Text('Agregar producto'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PantallaCarrito()),
              ),
              child: const Text('Ir al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO 4: el carrito lee el mismo modelo
class PantallaCarrito extends StatelessWidget {
  const PantallaCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito')),
      body: Center(
        child: Consumer<ContadorModel>(
          builder: (context, modelo, _) => Text('Productos: ${modelo.items}'),
        ),
      ),
    );
  }
}