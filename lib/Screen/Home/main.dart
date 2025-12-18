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
        brightness: Brightness.light,
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
      //home: const Inicio(),
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
  bool _isLoading = false;
  bool _obscurePassword = true;

  Sqlite_handler miSqliteHandler = Sqlite_handler();

  final _formKey = GlobalKey<FormState>();
  //funcion de inicio de sesion

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

  Future<bool> buscar(BuildContext context) async{
    bool existe = false;
    //if(_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      List<Usuario> busca = await consulta(username);
      if(busca.length > 0){
        existe = true;
      }
    //}
    return existe;
  }

  void comprobarUsuario(BuildContext context) async{
    bool resu = await buscar(context);
    if(resu){
      Navigator.pushNamed(context, RUTA_MAIN);
    }
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (_usernameController.text == 'usuario' &&
        _passwordController.text == 'password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión exitoso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Se eliminó el AppBar completamente
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
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
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
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
              ),
              const SizedBox(height: 24.0),
              //_isLoading
              //    ? const Center(child: CircularProgressIndicator())
              ElevatedButton(
                onPressed: (){
                  comprobarUsuario(context);
                },
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text('Función de recuperación de contraseña')),
                  );
                },
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
              TextButton(
                onPressed: () {
                  /*
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Navegar a pantalla de registro')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                   */
                  Navigator.pushNamed(context, RUTA_REGISTER);
                },
                child:const Text('¿No tienes una cuenta? Regístrate'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
