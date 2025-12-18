import 'package:afoooooo/common/Myroutes.dart';
import 'package:afoooooo/common/Usuario.dart'; // Asegúrate de que Usuario.dart exista
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

  Sqlite_handler miSqliteHandler = Sqlite_handler();
  final _formKey = GlobalKey<FormState>(); // Llave del formulario
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Lógica de Registro Corregida
  Future<void> procesarRegistro(BuildContext context) async {
    // 1. Validar el formulario visualmente
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      String nombre = _fullNameController.text.trim();
      String correo = _emailController.text.trim();

      try {
        final db = await miSqliteHandler.getDB();

        // 2. Verificar si ya existe el usuario
        final List<Map<String, Object?>> existe = await db.query(
          'usuarios',
          where: 'usuario = ?',
          whereArgs: [username],
        );

        if (existe.isEmpty) {
          // 3. Insertar nuevo usuario
          await db.insert('usuarios', {
            "usuario": username, // Consistencia: usamos 'username'
            "pass": password,
            "nombre": nombre,
            "correo": correo
          });

          if (!mounted) return; // Chequeo de seguridad de Flutter
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuario registrado con éxito")),
          );

          // 4. Navegar al Login después de guardar
          await Future.delayed(const Duration(seconds: 1));
          Navigator.popAndPushNamed(context, RUTA_LOGIN);

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("El nombre de usuario ya está en uso")),
          );
        }
      } catch (e) {
        print("Error en registro: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error de base de datos")),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Widget _buildVisibilityToggle(bool isObscure, Function(bool) onChanged) {
    return IconButton(
      icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
      onPressed: () => setState(() => onChanged(!isObscure)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form( // IMPORTANTE: Todo dentro de Form
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40.0),

                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (val) => val!.isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (val) => val!.isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.account_circle_outlined),
                  ),
                  validator: (val) => val!.isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: _buildVisibilityToggle(
                        _obscurePassword, (val) => _obscurePassword = val),
                  ),
                  validator: (val) => val!.isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: _buildVisibilityToggle(_obscureConfirmPassword,
                            (val) => _obscureConfirmPassword = val),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) return 'Campo requerido';
                    if (val != _passwordController.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),

                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: () {
                    procesarRegistro(context);
                  },
                  child: const Text('Registrar'),
                ),
                const SizedBox(height: 16.0),

                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, RUTA_LOGIN);
                  },
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