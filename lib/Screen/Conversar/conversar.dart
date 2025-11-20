import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// -------------------------------------------------------------------------
// 1. CONFIGURACIÓN GENERAL DEL TEMA
// -------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.blue.shade700;
    const Color lightBlueBackground = Color(0xFFE3F2FD);

    return MaterialApp(
      title: 'Conversar App',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBlueBackground,
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
            borderSide: BorderSide(color: primaryBlue, width: 2.0),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 18.0),
            elevation: 2,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryBlue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      themeMode: ThemeMode.light,
      home: const ConversationScreen(),
    );
  }
}

// -------------------------------------------------------------------------
// 2. PANTALLA "CONVERSAR" (SIN APPBAR)
// -------------------------------------------------------------------------

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _textController = TextEditingController();
  int _selectedIndex = 1;

  // Simulación de lectura en voz alta
  void _readText() {
    String text = _textController.text.trim();
    if (text.isEmpty) {
      text = "Por favor, escribe algo para leer.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Simulando lectura en voz alta: "$text"')),
    );
  }

  // Ítems de la barra inferior
  final List<BottomNavigationBarItem> bottomNavItems = const [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sin AppBar
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Título principal
                const Text(
                  'Conversar',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Ícono principal
                Icon(
                  Icons.record_voice_over,
                  size: 100,
                  color: Colors.blueGrey.shade700,
                ),
                const SizedBox(height: 32.0),

                // Descripción
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Escribe algo y presiona el botón para escucharlo en voz alta.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),

                // Campo de texto
                TextField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Escribe algo...',
                  ),
                ),
                const SizedBox(height: 24.0),

                // Botón "Leer texto"
                ElevatedButton(
                  onPressed: _readText,
                  child: const Text('Leer texto'),
                ),

                const SizedBox(height: 60.0),

                // Frase motivacional
                const Text(
                  '¡Tu voz también comunica! 🎤',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navegando a ${bottomNavItems[index].label}')),
          );
        },
      ),
    );
  }
}
