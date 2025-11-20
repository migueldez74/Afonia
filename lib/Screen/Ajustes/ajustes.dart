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
      title: 'Ajustes App',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBlueBackground,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black87,
            backgroundColor: Colors.white,
            padding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle:
            const TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
            elevation: 1,
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
      home: const SettingsScreen(),
    );
  }
}

// -------------------------------------------------------------------------
// 2. WIDGET DE ITEM DE AJUSTES CON ICONO
// -------------------------------------------------------------------------

class SettingsButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;

  const SettingsButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.blue,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: iconColor),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

// -------------------------------------------------------------------------
// 3. PANTALLA DE AJUSTES
// -------------------------------------------------------------------------

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 3;

  String? _selectedVoice = 'Generica - es-us-x-sfb-network';
  final List<String> _voiceOptions = [
    'Generica - es-us-x-sfb-network',
    'Voz 2 - es-mx-x-sfb-network',
    'Voz 3 - es-es-x-sfb-network',
  ];

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
    final Color primaryBlue = Theme.of(context).primaryColor;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Ajustes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 32.0),

            // Selector de Voz del Sistema
            Row(
              children: [
                Icon(Icons.psychology_outlined, color: primaryBlue),
                const SizedBox(width: 8.0),
                const Text(
                  'Voz del sistema',
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedVoice,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedVoice = newValue;
                    });
                  },
                  items: _voiceOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // Botón Acerca de la app
            SettingsButton(
              title: 'Acerca de la app',
              icon: Icons.info_outline,
              iconColor: primaryBlue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Abriendo información de la app')),
                );
              },
            ),
            const SizedBox(height: 16.0),

            // Botón Cerrar Sesión
            SettingsButton(
              title: 'Cerrar sesión',
              icon: Icons.lock_open,
              iconColor: Colors.red.shade700,
              textColor: Colors.red.shade700,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cerrando sesión...')),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Navegando al ítem ${bottomNavItems[index].label}')),
          );
        },
      ),
    );
  }
}
