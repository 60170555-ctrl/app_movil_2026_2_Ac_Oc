import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MiApp());

// ===========================================================================
// APP PRINCIPAL
// ===========================================================================
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF12314D),
      ).copyWith(
        primary: const Color(0xFF12314D),
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFF12314D),
        onPrimaryContainer: Colors.white,
        surface: const Color(0xFFF6F9FB),
        onSurface: const Color(0xFF12314D),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anticipa Azángaro',
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF12314D),
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

// ===========================================================================
// MODELO: argumentos que se envían a la pantalla de detalle
// (equivalente a lib/models/product_args.dart)
// ===========================================================================
class ProductArgs {
  const ProductArgs({
    required this.name,
    required this.price,
    required this.description,
  });

  final String name;
  final double price;
  final String description;
}

// ===========================================================================
// RUTAS CENTRALIZADAS
// (equivalente a lib/routes/app_routes.dart)
// ===========================================================================
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String detail = '/detalle';
  static const String quantity = '/cantidad';
  static const String register = '/registro';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case detail:
        final args = settings.arguments;
        if (args is ProductArgs) {
          return MaterialPageRoute<void>(
            builder: (_) => DetailScreen(args: args),
            settings: settings,
          );
        }
        return _errorRoute(
          'La ruta $detail requiere un objeto ProductArgs válido.',
        );

      case quantity:
        return MaterialPageRoute<int>(
          builder: (_) => const QuantityScreen(),
          settings: settings,
        );

      case register:
        return MaterialPageRoute<void>(
          builder: (_) => const RegistroPage(),
          settings: settings,
        );

      default:
        return _errorRoute('Ruta no encontrada: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute<void>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error de navegación')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// WIDGET REUTILIZABLE: ProductCard
// NO conoce rutas: el comportamiento al tocar lo decide quien lo usa
// mediante [onTap].
// (equivalente a lib/widgets/product_card.dart)
// ===========================================================================
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

// ===========================================================================
// WIDGET REUTILIZABLE: SectionTitle
// Título de sección con el estilo y color del tema.
// (equivalente a lib/widgets/section_title.dart)
// ===========================================================================
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}

// ===========================================================================
// WIDGET REUTILIZABLE: QuantitySelector
// Sin estado propio: el valor vive en la pantalla que lo usa (el estado
// "sube" al padre) y este widget solo notifica con [onChanged].
// (equivalente a lib/widgets/quantity_selector.dart)
// ===========================================================================
class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 20,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          onPressed: value > min ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 24),
        Text(
          '$value',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(width: 24),
        IconButton.filledTonal(
          onPressed: value < max ? () => onChanged(value + 1) : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

// ===========================================================================
// PANTALLA: HomeScreen  (equivalente a lib/screens/home_screen.dart)
// ===========================================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<ProductArgs> productos = [
    ProductArgs(
      name: 'Quinua orgánica 1 kg',
      price: 12.50,
      description: 'Quinua del altiplano puneño.',
    ),
    ProductArgs(
      name: 'Chuño blanco 500 g',
      price: 9.00,
      description: 'Chuño blanco de producción local.',
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
    Navigator.pushNamed(
      context,
      AppRoutes.detail,
      arguments: producto,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vilca Market')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle('Productos de la región'),
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

// ===========================================================================
// PANTALLA: DetailScreen  (equivalente a lib/screens/detail_screen.dart)
// ===========================================================================
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

    if (!mounted) return;

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
          const Center(child: SectionTitle('Descripción del producto')),
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
                  _dato(
                    'Total',
                    'S/ ${total.toStringAsFixed(2)}',
                    destacado: true,
                  ),
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

// ===========================================================================
// PANTALLA: QuantityScreen  (equivalente a lib/screens/quantity_screen.dart)
// ===========================================================================
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
              const Text('¿Cuántas unidades deseas?'),
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

// ===========================================================================
// PANTALLA: RegistroPage  (equivalente a lib/screens/registro_screen.dart)
// ===========================================================================
class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _usuarioCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  final _celularCtrl = TextEditingController();

  final Map<String, String> _datos = {};
  String _saludo = '';

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _usuarioCtrl.dispose();
    _correoCtrl.dispose();
    _dniCtrl.dispose();
    _celularCtrl.dispose();
    super.dispose();
  }

  String? _validarNombre(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingresa tus nombres y apellidos';
    if (texto.length < 3) return 'Escribe al menos 3 caracteres';
    if (!RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñÜü ]+$').hasMatch(texto)) {
      return 'Usa solo letras y espacios';
    }
    return null;
  }

  String? validarNombreUsuario(String? valor) {
    final texto = valor?.trim() ?? '';

    if (texto.isEmpty) {
      return 'El nombre de usuario es obligatorio';
    }
    if (texto.length < 4) {
      return 'Debe tener al menos 4 caracteres';
    }
    if (texto.length > 15) {
      return 'No puede superar los 15 caracteres';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(texto)) {
      return 'Solo se permiten letras sin tildes, números y guion bajo (_)';
    }
    if (RegExp(r'^[0-9]').hasMatch(texto)) {
      return 'No puede empezar con un número';
    }
    return null;
  }

  String? _validarCorreo(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingresa tu correo electrónico';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(texto)) {
      return 'Escribe un correo válido (usuario@dominio.com)';
    }
    return null;
  }

  String? _validarDni(String? valor) {
    final texto = valor ?? '';
    if (texto.isEmpty) return 'Ingresa tu DNI';
    if (texto.length != 8) return 'El DNI debe tener exactamente 8 dígitos';
    return null;
  }

  String? _validarCelular(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return null; // opcional: vacío es válido
    if (!RegExp(r'^\d+$').hasMatch(texto)) return 'Usa solo dígitos';
    if (texto.length != 9) return 'El celular debe tener 9 dígitos';
    if (!texto.startsWith('9')) return 'El celular debe empezar con 9';
    return null;
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso: ${_datos['nombre']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anticipa Azángaro · Registro'),
        backgroundColor: colores.primaryContainer,
        foregroundColor: colores.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_saludo.isNotEmpty) ...[
                Text(_saludo, style: textos.headlineSmall),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nombreCtrl,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[A-Za-zÁÉÍÓÚáéíóúÑñÜü ]'),
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: 'Nombres y apellidos',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: _validarNombre,
                onChanged: (valor) {
                  final primero = valor.trim().split(' ').first;
                  setState(() {
                    _saludo = primero.isEmpty ? '' : 'Hola, $primero';
                  });
                },
                onSaved: (valor) => _datos['nombre'] = valor!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usuarioCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                validator: validarNombreUsuario,
                onSaved: (valor) => _datos['usuario'] = valor!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoCtrl,
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: _validarCorreo,
                onSaved: (valor) => _datos['correo'] = valor!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dniCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                decoration: const InputDecoration(
                  labelText: 'DNI',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: _validarDni,
                onSaved: (valor) => _datos['dni'] = valor!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _celularCtrl,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                decoration: const InputDecoration(
                  labelText: 'Celular (opcional)',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: _validarCelular,
                onSaved: (valor) => _datos['celular'] = valor!.trim(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _enviar,
                  icon: const Icon(Icons.how_to_reg),
                  label: const Text('Registrarme'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}