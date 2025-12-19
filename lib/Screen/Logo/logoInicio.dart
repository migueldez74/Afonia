import 'package:afoooooo/Screen/Ajustes/ajustes.dart';
import 'package:afoooooo/Screen/Home/main.dart';
import 'package:afoooooo/Screen/Principal/menuPrincipal.dart';
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
      backgroundColor: Color.fromRGBO(8, 47, 141, 0.8156862745098039),
      body: Center(
        
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const LoginPage() )

                );
              },
              child: Image.asset(
                'assets/image/logo.png',
                width: 250,
                height: 250,

              ),
            ),
            
            ElevatedButton(onPressed: ()
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> const LoginPage() )

              );
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(
                    83, 198, 250, 0.2784313725490196),
                foregroundColor: Color.fromRGBO(195, 226, 245, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )

              ),
                child: Text("Iniciar"),

            ),
          ],
        )
      ),
    );

  }
}





