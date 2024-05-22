import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _translatedText = '';
  final String apiKey =
      'sk-proj-A9OUtPPDPj40WVkDXzHCT3BlbkFJtr1j43DaVWBwTQ6ZTT4E'; // Reemplaza con tu clave de API de OpenAI

  Future<void> _translateText() async {
    String text = _textEditingController.text.trim();

    if (text.isEmpty) {
      // No hacer nada si el cuadro de texto está vacío
      return;
    }

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'text-davinci-003',
        'prompt': 'Translate the following Spanish text to English: "$text"',
        'max_tokens': 60,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _translatedText = jsonResponse['choices'][0]['text'].trim();
      });
    } else {
      // Manejar el error de la solicitud fallida
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to load translation: ${response.statusCode}')),
      );
    }
  }

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
}
