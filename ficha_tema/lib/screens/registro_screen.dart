import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      return 'Solo se permiten letras sin tildes, numeros y guion bajo (_)';
    }
    if (RegExp(r'^[0-9]').hasMatch(texto)) {
      return 'No puede empezar con un numero';
    }
    return null;
  }

  String? _validarCorreo(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Ingresa tu correo electronico';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(texto)) {
      return 'Escribe un correo valido (usuario@dominio.com)';
    }
    return null;
  }

  String? _validarDni(String? valor) {
    final texto = valor ?? '';
    if (texto.isEmpty) return 'Ingresa tu DNI';
    if (texto.length != 8) return 'El DNI debe tener exactamente 8 digitos';
    return null;
  }

  String? _validarCelular(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return null; // opcional: vacio es valido
    if (!RegExp(r'^\d+$').hasMatch(texto)) return 'Usa solo digitos';
    if (texto.length != 9) return 'El celular debe tener 9 digitos';
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
        title: const Text('Anticipa Azangaro - Registro'),
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
                  labelText: 'Correo electronico',
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