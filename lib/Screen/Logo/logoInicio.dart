import 'package:afoooooo/Screen/Ajustes/ajustes.dart';
import 'package:afoooooo/Screen/Home/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Inicio extends StatefulWidget{
 const Inicio ({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(9, 36, 115, 0.9098039215686274),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> const LoginPage() )

            );
          },
          child: Image.asset(
          'assets/image/logo.png',
            width: 250,
            height: 250,

          ),
        ),
      ),
    );



  }
}





