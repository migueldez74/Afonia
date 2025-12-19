// En: lib/Screen/Home/main.dart

import 'package:afoooooo/Screen/Logo/logoInicio.dart';
import 'package:afoooooo/common/Myroutes.dart';
import 'package:afoooooo/common/Usuario.dart';
import 'package:afoooooo/handlers/Sqlite_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ----------------------------------------------------
// CLASE PRINCIPAL DE LA APLICACIÓN CON EL TEMA GLOBAL
// ----------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afonias App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        brightness: Brightness.light,

        // --- TEMA DE LA BARRA DE NAVEGACIÓN CORREGIDO Y AÑADIDO ---
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black87,         // Fondo oscuro
          selectedItemColor: Colors.white,         // Ítem seleccionado: BLANCO
          unselectedItemColor: Colors.grey.shade400, // Ítem no seleccionado: GRIS CLARO
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // ---------------------------------------------------------

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2.0),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 18.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue.shade700,
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      onGenerateRoute: MyRoutes.rutasGeneradas,
      initialRoute: RUTA_HOME,
    );
  }
}

// ----------------------------------------------------
// PANTALLA DE INICIO DE SESIÓN (LOGIN)
// ----------------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Sqlite_handler _miSqliteHandler = Sqlite_handler();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  // --- FUNCIÓN DE LOGIN CORREGIDA ---
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Llama a la función que valida AMBAS credenciales
      final usuario = await _miSqliteHandler.getUsuario(username, password);

      if (mounted) {
        if (usuario != null) {
          // ¡ÉXITO! Navega a la pantalla principal
          Navigator.pushReplacementNamed(context, RUTA_MAIN);
        } else {
          // FRACASO: Muestra mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario o contraseña incorrectos.'), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Iniciar Sesión', textAlign: TextAlign.center, style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 50.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Usuario', prefixIcon: Icon(Icons.person)),
                  validator: (value) => value == null || value.isEmpty ? 'Ingresa tu usuario' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña', prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Ingresa tu contraseña' : null,
                ),
                const SizedBox(height: 24.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _login,
                  child: const Text('Iniciar'),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () { /* Lógica de olvidaste contraseña */ },
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, RUTA_REGISTER),
                  child: const Text('¿No tienes una cuenta? Regístrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
