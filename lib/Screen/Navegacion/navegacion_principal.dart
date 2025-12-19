// En: lib/Screen/Navegacion/navegacion_principal.dart

import 'package:afoooooo/Screen/Ajustes/ajustes.dart';
import 'package:afoooooo/Screen/Conversar/conversar.dart';
import 'package:afoooooo/Screen/Frases/frases.dart';
import 'package:afoooooo/Screen/Principal/menuPrincipal.dart';
import 'package:flutter/material.dart';

class NavegacionPrincipal extends StatefulWidget {
  const NavegacionPrincipal({super.key});

  @override
  State<NavegacionPrincipal> createState() => _NavegacionPrincipalState();
}

class _NavegacionPrincipalState extends State<NavegacionPrincipal> {
  // 1. Variable que guarda el índice de la pantalla actual.
  int _selectedIndex = 0;

  // 2. Lista de las pantallas a las que vamos a navegar.
  //    El orden DEBE COINCIDIR con el orden de los botones de la barra.
  static const List<Widget> _pantallas = <Widget>[
    MainMenuScreen(),   // Índice 0: Inicio
    ConversationScreen(), // Índice 1: Conversar
    PhraseScreen(),     // Índice 2: Frases
    SettingsScreen(),     // Índice 3: Ajustes
  ];

  // 3. Función que se ejecuta cuando se toca un ítem.
  //    Actualiza el estado con el nuevo índice.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 4. El cuerpo del Scaffold ahora es la pantalla seleccionada de la lista.
      body: _pantallas.elementAt(_selectedIndex),

      // 5. La ÚNICA BottomNavigationBar que necesitas en tu app principal.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outlined),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Conversar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields_outlined),
            activeIcon: Icon(Icons.text_fields),
            label: 'Frases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _selectedIndex, // El ítem actual se basa en nuestra variable de estado.
        onTap: _onItemTapped,      // Al tocar, se llama a nuestra función para cambiar de pantalla.
        // ¡No necesitas definir el estilo aquí! Lo tomará del tema global en main.dart.
      ),
    );
  }
}
