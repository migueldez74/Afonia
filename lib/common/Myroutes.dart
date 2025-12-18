import 'package:afoooooo/Screen/Datos/cuenta.dart';
import 'package:afoooooo/Screen/Home/main.dart';
import 'package:afoooooo/Screen/Logo/logoInicio.dart';
import 'package:flutter/material.dart';

//import 'package:manejo_witgets/PaginaInicio.dart';

const String RUTA_HOME ="/home";
const String RUTA_LOGIN = "/login"; //esta ya esta
const String RUTA_REGISTER = "/register";
const String RUTA_MAIN = "/main";

class MyRoutes{
  static Route<dynamic>rutasGeneradas(RouteSettings settings){
    switch (settings.name){
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginPage());
      case "/register":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/home":
        return MaterialPageRoute(builder: (_)=> Inicio());
        case "/main":
          return MaterialPageRoute(builder: (_)=> MyApp());
      default:
        return MaterialPageRoute(builder: (_) => Inicio());
    }
  }
}