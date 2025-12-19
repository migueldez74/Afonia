// En: Screen/Datos/cuenta.dart

import 'package:afoooooo/common/Myroutes.dart';
import 'package:afoooooo/common/Usuario.dart';
import 'package:afoooooo/handlers/Sqlite_handler.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final Sqlite_handler _miSqliteHandler = Sqlite_handler();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;


  Future<void> _registrarUsuario() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final nuevoUsuario = Usuario(
        nombre: _fullNameController.text,
        correo: _emailController.text,
        usuario: _usernameController.text,
        pass: _passwordController.text,
      );

      await _miSqliteHandler.insertarUsuario(nuevoUsuario);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Usuario registrado con éxito!'), backgroundColor: Colors.green),
        );
        // Y AHORA SÍ, navega a la pantalla de login
        Navigator.popAndPushNamed(context, RUTA_LOGIN);
      }

    } catch (e) {
      // Si el `insertarUsuario` falló (ej: usuario duplicado), muestra el error.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst("Exception: ", "")), backgroundColor: Colors.red),
        );
      }
    } finally {
      // Al final, siempre oculta el indicador de carga
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildVisibilityToggle(bool isObscure, VoidCallback onPressed) {
    return IconButton(icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility), onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form( // Envuelve todo en un Form
            key: _formKey, // Asigna la clave
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Crear cuenta', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40.0),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Nombre completo', prefixIcon: Icon(Icons.person_outline)),
                  validator: (value) => value == null || value.isEmpty ? 'El nombre no puede estar vacío' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Correo electrónico', prefixIcon: Icon(Icons.mail_outline)),
                  validator: (value) => value == null || !value.contains('@') ? 'Introduce un correo válido' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Usuario', prefixIcon: Icon(Icons.account_circle_outlined)),
                  validator: (value) => value == null || value.isEmpty ? 'El usuario no puede estar vacío' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña', prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: _buildVisibilityToggle(_obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
                  ),
                  validator: (value) => value == null || value.length < 6 ? 'La contraseña debe tener al menos 6 caracteres' : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña', prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: _buildVisibilityToggle(_obscureConfirmPassword, () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _registrarUsuario, // Llama a la función CORREGIDA
                  child: const Text('Registrar'),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () => Navigator.popAndPushNamed(context, RUTA_LOGIN),
                  child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
