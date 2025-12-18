import 'package:afoooooo/common/Usuario.dart';
import 'package:afoooooo/handlers/Sqlite_handler.dart';
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

  Sqlite_handler miSqliteHandler = Sqlite_handler();
  final _formKey = GlobalKey<FormState>();

  //registro usuarios
  late List<Usuario> usuarios;
  Future<List<Usuario>> consulta(String username) async{
    final db = await miSqliteHandler.getDB();
    final List<Map<String, Object?>> mapaUsuario = await
    db.rawQuery("select * from usuarios where username = '$username'");
    return [
      for(final {'usuario':usuario as String, 'pass':pass as String, 'nombre':nombre as String, 'correo':correo as String} in mapaUsuario)
        Usuario(usuario: usuario, pass: pass, nombre: nombre, correo: correo),
    ];
  }

  //agregar usuario
  Future<bool> agregarUsuario(BuildContext context) async{
    bool agregado = false;
    if(_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      String nombre = _fullNameController.text;
      String correo = _emailController.text;

      List<Usuario> busca = await consulta(username);
      if(busca.length == 0){
        agregado = true;
        try{
          var db = await miSqliteHandler.getDB();
          await db.insert('usuarios', {
            "usuario": username,
            "pass": password,
            "nombre": nombre,
            "correo": correo
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Usuario agregado"),
              duration: const Duration(seconds: 3),
            ),
          );
        }catch(e){
          print(e.toString());
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuario ya registrado"),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
    return agregado;
  }

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
