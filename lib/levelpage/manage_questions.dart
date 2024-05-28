import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'question.dart';
import 'config_question.dart';

class EditQuestionsScreen extends StatefulWidget {
  const EditQuestionsScreen({super.key});

  @override
  EditQuestionsScreenState createState() => EditQuestionsScreenState();
}

class EditQuestionsScreenState extends State<EditQuestionsScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  final TextEditingController _correctOptionController =
      TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  late Future<void> _initialLoad;

  @override
  void initState() {
    super.initState();
    _initialLoad = _loadQuestionsFromFile();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/questions.txt');
  }

  Future<void> _writeQuestionsToFile() async {
    final file = await _localFile;
    final questions = questionManager.getAllQuestions();
    final serializedQuestions = questions.map((q) => q.serialize()).join('\n');
    await file.writeAsString(serializedQuestions);
  }

  Future<void> _loadQuestionsFromFile() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final questions = contents
            .split('\n')
            .where((line) => line.isNotEmpty)
            .map((line) => Question.deserialize(line))
            .toList();
        setState(() {
          questionManager.setQuestions(questions);
        });
      }
    } catch (e) {
      // Si el archivo no existe o hay un error de lectura, simplemente ignoramos
    }
  }

  void _addQuestion() {
    final question = Question(
      questionText: _questionController.text,
      options: [
        _option1Controller.text,
        _option2Controller.text,
        _option3Controller.text,
        _option4Controller.text,
      ],
      correctOptionIndex: int.parse(_correctOptionController.text),
      level: int.parse(_levelController.text),
    );
    questionManager.addQuestion(question);
    setState(() {});

    _writeQuestionsToFile();

    _questionController.clear();
    _option1Controller.clear();
    _option2Controller.clear();
    _option3Controller.clear();
    _option4Controller.clear();
    _correctOptionController.clear();
    _levelController.clear();
  }

  void _removeQuestion(String questionText) {
    questionManager.removeQuestion(questionText);
    setState(() {});

    _writeQuestionsToFile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error loading questions: ${snapshot.error}'));
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('Edit Questions')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _questionController,
                      decoration:
                          const InputDecoration(labelText: 'Question Text'),
                    ),
                    TextField(
                      controller: _option1Controller,
                      decoration: const InputDecoration(labelText: 'Option 1'),
                    ),
                    TextField(
                      controller: _option2Controller,
                      decoration: const InputDecoration(labelText: 'Option 2'),
                    ),
                    TextField(
                      controller: _option3Controller,
                      decoration: const InputDecoration(labelText: 'Option 3'),
                    ),
                    TextField(
                      controller: _option4Controller,
                      decoration: const InputDecoration(labelText: 'Option 4'),
                    ),
                    TextField(
                      controller: _correctOptionController,
                      decoration: const InputDecoration(
                          labelText: 'Correct Option Index'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: _levelController,
                      decoration: const InputDecoration(labelText: 'Level'),
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                      onPressed: _addQuestion,
                      child: const Text('Add Question'),
                    ),
                    const Text(
                      'Questions:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: questionManager.getAllQuestions().length,
                      itemBuilder: (context, index) {
                        final question =
                            questionManager.getAllQuestions()[index];
                        return ListTile(
                          title: Text(question.questionText),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _removeQuestion(question.questionText),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
