import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'screens/login_page.dart';
import 'screens/menu_page.dart';

void main() => runApp(const FoodApp());

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos o serviço aqui (Injeção de Dependência manual - KISS)
    final IAuthService authService = MockAuthService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<String?>(
        stream: authService.onAuthStateChanged,
        builder: (context, snapshot) {
          // Se o stream emitir um dado (token), mostra o cardápio
          if (snapshot.hasData && snapshot.data != null) {
            return MenuPage(onLogout: () => authService.logout());
          }
          // Caso contrário (null), mostra login
          return LoginPage(authService: authService);
        },
      ),
    );
  }
}