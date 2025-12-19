// En: lib/common/Myroutes.dart

import 'package:afoooooo/Screen/Datos/cuenta.dart';
import 'package:afoooooo/Screen/Home/main.dart';
import 'package:afoooooo/Screen/Logo/logoInicio.dart';
// Importa el NUEVO archivo
import 'package:afoooooo/Screen/Navegacion/navegacion_principal.dart';
import 'package:flutter/material.dart';

const String RUTA_HOME = "/";
const String RUTA_LOGIN = "/login";
const String RUTA_REGISTER = "/register";
const String RUTA_MAIN = "/main";

class MyRoutes {
  static Route<dynamic> rutasGeneradas(RouteSettings settings) {
    switch (settings.name) {
      case RUTA_HOME:
        return MaterialPageRoute(builder: (context) => const Inicio());
      case RUTA_LOGIN:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case RUTA_REGISTER:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

    // --- CAMBIO IMPORTANTE AQUÍ ---
    // Ahora RUTA_MAIN te lleva al controlador de navegación.
      case RUTA_MAIN:
        return MaterialPageRoute(builder: (context) => const NavegacionPrincipal());

      default:
        return MaterialPageRoute(builder: (context) => const Inicio());
    }
  }
}
