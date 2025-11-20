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
      title: 'Frases Comunes App',
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
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle:
            const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
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
      home: const PhraseScreen(),
    );
  }
}

// -------------------------------------------------------------------------
// 2. WIDGET DE ITEM DE FRASE
// -------------------------------------------------------------------------

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
            icon: const Icon(Icons.volume_up, color: Colors.blue),
            onPressed: onSpeak,
          ),
          title: Text(
            phrase,
            style: const TextStyle(fontSize: 17.0, color: Colors.black87),
          ),
          onTap: onSpeak,
        ),
        const Divider(
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}

// -------------------------------------------------------------------------
// 3. PANTALLA PRINCIPAL DE FRASES
// -------------------------------------------------------------------------

class PhraseScreen extends StatefulWidget {
  const PhraseScreen({super.key});

  @override
  State<PhraseScreen> createState() => _PhraseScreenState();
}

class _PhraseScreenState extends State<PhraseScreen> {
  int _selectedIndex = 2;
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
    'Quiero comer',
    'Necesito descansar',
    'Me llamo Liz',
    'Rist in piz',
  ];

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

  void _addPhrase() {
    final newPhrase = _newPhraseController.text.trim();
    if (newPhrase.isNotEmpty) {
      setState(() {
        _phrases.insert(0, newPhrase);
        _newPhraseController.clear();
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, left: 24.0, right: 24.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Frases comunes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
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
                      child: const Text('Agregar frase'),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                'Navegando al ítem ${bottomNavItems[index].label}',
              ),
            ),
          );
        },
      ),
    );
  }
}
