// En: Screen/Frases/frases.dart

import 'package:flutter/material.dart';

// --- NO MÁS main(), NO MÁS MyApp ---

// Widget de ítem de frase (sin cambios)
class PhraseItem extends StatelessWidget {
  final String phrase;
  final VoidCallback onSpeak;

  const PhraseItem({
    super.key,
    required this.phrase,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: IconButton(
            icon: Icon(Icons.volume_up, color: Theme.of(context).primaryColor),
            onPressed: onSpeak,
          ),
          title: Text(
            phrase,
            style: const TextStyle(fontSize: 17.0, color: Colors.black87),
          ),
          onTap: onSpeak,
          tileColor: Colors.white,
        ),
        const Divider(height: 1),
      ],
    );
  }
}

// Pantalla de Frases (simplificada)
class PhraseScreen extends StatefulWidget {
  const PhraseScreen({super.key});

  @override
  State<PhraseScreen> createState() => _PhraseScreenState();
}

class _PhraseScreenState extends State<PhraseScreen> {
  final TextEditingController _newPhraseController = TextEditingController();

  final List<String> _phrases = [
    'Hola, buenos días',
    '¿Puedes ayudarme?',
    'Gracias',
    'Quiero agua',
    'No me siento bien',
    'Estoy feliz',
    'Estoy triste',
    '¿Dónde está el baño?',
  ];

  void _addPhrase() {
    final newPhrase = _newPhraseController.text.trim();
    if (newPhrase.isNotEmpty) {
      setState(() {
        _phrases.insert(0, newPhrase);
        _newPhraseController.clear();
        FocusManager.instance.primaryFocus?.unfocus(); // Cierra el teclado
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Frase agregada: "$newPhrase"')),
      );
    }
  }

  void _speakPhrase(String phrase) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Simulando lectura en voz alta: "$phrase"')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AÑADIMOS UN APPBAR PARA CONSISTENCIA
      appBar: AppBar(
        title: const Text('Frases Comunes'),
      ),
      body: Column(
        children: <Widget>[
          // Panel para agregar nueva frase
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _newPhraseController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe una nueva frase',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addPhrase,
                  child: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Lista de frases
          Expanded(
            child: ListView.builder(
              itemCount: _phrases.length,
              itemBuilder: (context, index) {
                return PhraseItem(
                  phrase: _phrases[index],
                  onSpeak: () => _speakPhrase(_phrases[index]),
                );
              },
            ),
          ),
        ],
      ),
      // --- YA NO HAY bottomNavigationBar AQUÍ ---
    );
  }
}
