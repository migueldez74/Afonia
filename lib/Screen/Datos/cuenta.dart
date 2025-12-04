import 'package:flutter/material.dart';



//----------------------------------------------------
// Pantalla de Registro
//----------------------------------------------------
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controladores de texto
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  //----------------------------------------------------
  // Lógica de registro simulada
  //----------------------------------------------------
  Future<void> _register() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
    } else if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Registro exitoso!')),
      );
    }
  }

  //----------------------------------------------------
  // Icono para mostrar/ocultar contraseña
  //----------------------------------------------------
  Widget _buildVisibilityToggle(bool isObscure, Function(bool) onChanged) {
    return IconButton(
      icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
      onPressed: () {
        setState(() {
          onChanged(!isObscure);
        });
      },
    );
  }

  //----------------------------------------------------
  // Construcción de la interfaz
  //----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 AppBar eliminado para pantalla limpia
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Crear cuenta',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40.0),

              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16.0),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
              ),
              const SizedBox(height: 16.0),

              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.account_circle_outlined),
                ),
              ),
              const SizedBox(height: 16.0),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: _buildVisibilityToggle(
                    _obscurePassword,
                        (val) => _obscurePassword = val,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: _buildVisibilityToggle(
                    _obscureConfirmPassword,
                        (val) => _obscureConfirmPassword = val,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _register,
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 16.0),

              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navegar a Iniciar Sesión')),
                  );
                },
                child: const Text('¿Ya tienes cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
