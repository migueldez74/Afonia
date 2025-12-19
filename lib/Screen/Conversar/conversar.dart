// En: Screen/Conversar/conversar.dart

import 'package:flutter/material.dart';

// --- NO MÁS main(), NO MÁS MyApp ---

// Pantalla "Conversar" (simplificada)
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _textController = TextEditingController();

  void _readText() {
    String text = _textController.text.trim();
    if (text.isEmpty) {
      text = "Por favor, escribe algo para leer.";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Simulando lectura en voz alta: "$text"')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AÑADIMOS UN APPBAR PARA CONSISTENCIA
      appBar: AppBar(
        title: const Text('Conversar'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      // --- YA NO HAY bottomNavigationBar AQUÍ ---
    );
  }
}
