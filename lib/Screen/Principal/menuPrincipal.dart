// En: Screen/Principal/menuPrincipal.dart

import 'package:flutter/material.dart';

// --- NO MÁS main(), NO MÁS MyApp ---

// Widget de Módulo (sin cambios)
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
        style: ElevatedButton.styleFrom(
          // Podemos tomar el color del tema para consistencia
          backgroundColor: Theme.of(context).primaryColor,
        ),
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

// Pantalla de Menú Principal (simplificada)
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AÑADIMOS UN APPBAR PARA CONSISTENCIA
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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
      // --- YA NO HAY bottomNavigationBar AQUÍ ---
    );
  }
}
