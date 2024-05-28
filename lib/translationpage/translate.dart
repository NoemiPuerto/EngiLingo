import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Translate extends StatelessWidget {
  const Translate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TranslateScreen(),
    );
  }
}

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration:
                  const InputDecoration(labelText: 'Enter text in Spanish'),
            ),
            ElevatedButton(
              onPressed: _translateText,
              child: const Text('Translate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Translated Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _translatedText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  */
}

class _TranslateScreenState extends State<TranslateScreen> {
  final outputController = TextEditingController(text: "Result here...");
  final translator = GoogleTranslator();

  String inputText = '';
  String inputLanguage = 'es';
  String outputLanguage = 'en';

  Future<void> translateText() async {
    final translated = await translator.translate(inputText,
        from: inputLanguage, to: outputLanguage);
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Translator'),
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/teclatito.gif',
                    fit: BoxFit.contain,
                    height: 250,
                  ),
                  TextField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter text to translate",
                    ),
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: inputLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            inputLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'es',
                          'en',
                          'fr',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded),
                      DropdownButton<String>(
                        value: outputLanguage,
                        onChanged: (newValue) {
                          setState(() {
                            outputLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'es',
                          'en',
                          'fr',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: translateText,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55),
                      ),
                      child: const Text("Translate")),
                  const SizedBox(height: 30),
                  TextField(
                    controller: outputController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
