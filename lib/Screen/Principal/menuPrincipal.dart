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
      title: 'Menú Principal App',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBlueBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
      home: const MainMenuScreen(),
    );
  }
}

// -------------------------------------------------------------------------
// 2. WIDGET DE CADA MÓDULO
// -------------------------------------------------------------------------
class ModuleItem extends StatelessWidget {
  final String title;
  final bool isUnlocked;

  const ModuleItem({
    super.key,
    required this.title,
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isUnlocked) {
      return ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Iniciando $title')),
          );
        },
        icon: const Icon(Icons.play_arrow),
        label: Text(title),
      );
    }

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title está bloqueado. ¡Completa el anterior!')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: const <Widget>[
              Icon(Icons.lock, color: Colors.grey),
              SizedBox(width: 16.0),
              Text(
                'Módulo bloqueado',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// 3. PANTALLA PRINCIPAL SIN BARRA SUPERIOR
// -------------------------------------------------------------------------
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  final List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Inicio',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outline),
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
      // 🔹 Quitamos el AppBar completamente
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Módulos de práctica:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),

            // Lista de módulos
            const ModuleItem(title: 'Módulo 1', isUnlocked: true),
            const SizedBox(height: 8.0),
            const ModuleItem(title: 'Módulo 2'),
            const SizedBox(height: 8.0),
            const ModuleItem(title: 'Módulo 3'),
            const SizedBox(height: 8.0),
            const ModuleItem(title: 'Módulo 4'),
            const SizedBox(height: 8.0),
            const ModuleItem(title: 'Módulo 5'),
            const SizedBox(height: 40.0),

            // Pie de página
            Center(
              child: Column(
                children: [
                  const Text(
                    '© 2025 Afonic M.L.C',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '¡Sigue practicando para mejorar tu comunicación!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barra inferior
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: 0,
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navegando al ítem ${index + 1}')),
          );
        },
      ),
    );
  }
}
