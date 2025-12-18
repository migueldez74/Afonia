import 'package:afoooooo/Screen/Logo/logoInicio.dart';
import 'package:afoooooo/common/Myroutes.dart';
import 'package:afoooooo/common/Usuario.dart';
import 'package:afoooooo/handlers/Sqlite_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
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
          errorBorder: OutlineInputBorder( // Borde rojo para errores
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIconColor: Colors.grey,
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
      ),
      onGenerateRoute: MyRoutes.rutasGeneradas,
      initialRoute: RUTA_HOME, // Asegúrate de que esta ruta apunte a LoginPage si es lo primero que quieres ver
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Sqlite_handler miSqliteHandler = Sqlite_handler();
  final _formKey = GlobalKey<FormState>(); // 1. La llave del formulario

  // Lógica de Login corregida
  void intentarLogin(BuildContext context) async {
    // 2. Validar campos vacíos visualmente
    if (_formKey.currentState!.validate()) {

      String usernameInput = _usernameController.text.trim();
      String passwordInput = _passwordController.text.trim();

      // Consulta segura usando '?'
      final db = await miSqliteHandler.getDB();
      final List<Map<String, Object?>> resultados = await db.query(
        'usuarios',
        where: 'usuario = ?', // Asegúrate que tu columna en BD se llame 'username'
        whereArgs: [usernameInput],
      );

      if (resultados.isNotEmpty) {
        // El usuario existe, ahora verificamos la contraseña
        String passwordBD = resultados.first['pass'] as String;

        if (passwordBD == passwordInput) {
          // ¡ÉXITO!
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bienvenido')),
          );
          Navigator.pushNamed(context, RUTA_MAIN); // O RUTA_HOME según tu lógica
        } else {
          // Contraseña incorrecta
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      } else {
        // Usuario no encontrado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El usuario no existe')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Form( // 3. Envolvemos todo en un FORM
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Iniciar Sesión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50.0),

                // 4. Usamos TextFormField en lugar de TextField
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                ElevatedButton(
                  onPressed: () {
                    intentarLogin(context);
                  },
                  child: const Text('Iniciar sesión'),
                ),

                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RUTA_REGISTER);
                  },
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