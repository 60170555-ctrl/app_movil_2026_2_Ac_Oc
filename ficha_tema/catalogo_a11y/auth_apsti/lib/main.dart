import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final hasSession = await authService.hasSession();
  
  runApp(MyApp(hasSession: hasSession));
}

class MyApp extends StatelessWidget {
  final bool hasSession;
  const MyApp({super.key, required this.hasSession});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acceso PV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: hasSession ? const HomeScreen() : const LoginScreen(),
    );
  }
}
