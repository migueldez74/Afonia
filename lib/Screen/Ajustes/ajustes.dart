// En: lib/Screen/Ajustes/ajustes.dart

import 'package:flutter/material.dart';

// --- NO MÁS main(), NO MÁS MyApp ---

// Widget de botón (sin cambios)
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
        child: Text(title, style: TextStyle(color: textColor)),
      ),
      style: ElevatedButton.styleFrom(alignment: Alignment.centerLeft),
    );
  }
}

// Pantalla de Ajustes (simplificada)
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedVoice = 'Generica - es-us-x-sfb-network';
  final List<String> _voiceOptions = [
    'Generica - es-us-x-sfb-network',
    'Voz 2 - es-mx-x-sfb-network',
    'Voz 3 - es-es-x-sfb-network',
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Theme.of(context).primaryColor;

    return Scaffold(
      // AÑADIMOS UN APPBAR PARA CONSISTENCIA
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // El contenido de la pantalla no cambia...
            // Selector de Voz, botones, etc.
            Row(
              children: [
                Icon(Icons.psychology_outlined, color: primaryBlue),
                const SizedBox(width: 8.0),
                const Text('Voz del sistema', style: TextStyle(fontSize: 18.0, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
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
                  items: _voiceOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            SettingsButton(
              title: 'Acerca de la app',
              icon: Icons.info_outline,
              iconColor: primaryBlue,
              onTap: () {},
            ),
            const SizedBox(height: 16.0),
            SettingsButton(
              title: 'Cerrar sesión',
              icon: Icons.lock_open,
              iconColor: Colors.red.shade700,
              textColor: Colors.red.shade700,
              onTap: () {},
            ),
          ],
        ),
      ),
      // --- YA NO HAY bottomNavigationBar AQUÍ ---
    );
  }
}
