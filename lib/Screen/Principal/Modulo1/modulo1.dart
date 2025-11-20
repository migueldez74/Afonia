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
      title: 'Módulo 1 Ejercicios',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBlueBackground,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 18.0),
            elevation: 2,
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      home: const ModuleOneScreen(),
    );
  }
}

// -------------------------------------------------------------------------
// 2. WIDGET DE ITEM DE EJERCICIO
// -------------------------------------------------------------------------

class ExerciseItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const ExerciseItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Iniciando: $title')),
          );
        },
        icon: Align(
          alignment: Alignment.centerLeft,
          widthFactor: 1.0,
          child: Icon(icon, size: 28.0),
        ),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(title, textAlign: TextAlign.left),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// 3. PANTALLA DE MÓDULO 1 (SIN APPBAR)
// -------------------------------------------------------------------------

class ModuleOneScreen extends StatelessWidget {
  const ModuleOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sin AppBar
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Título principal
              const Center(
                child: Text(
                  'Módulo 1: Ejercicios de rehabilitación',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24.0),

              // Lista de ejercicios
              ExerciseItem(
                title: 'Ejercicio 1: Vocales sostenidas',
                icon: Icons.mic_none,
              ),
              const SizedBox(height: 8.0),
              ExerciseItem(
                title: 'Ejercicio 2: Respiración controlada',
                icon: Icons.air,
              ),
              const SizedBox(height: 8.0),
              ExerciseItem(
                title: 'Ejercicio 3: Zumbido nasal',
                icon: Icons.sentiment_neutral,
              ),
              const SizedBox(height: 8.0),
              ExerciseItem(
                title: 'Ejercicio 4: Sílabas repetidas',
                icon: Icons.group_add_outlined,
              ),
              const SizedBox(height: 8.0),
              ExerciseItem(
                title: 'Ejercicio 5: Frases simples',
                icon: Icons.headphones_outlined,
              ),

              const SizedBox(height: 100.0),

              // Mensaje motivacional
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Continúa con tu práctica diaria 💪',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
