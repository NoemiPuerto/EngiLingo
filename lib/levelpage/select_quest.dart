import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'question.dart';
import 'quiz.dart';

class SelectQuestScreen extends StatefulWidget {
  final int level;

  SelectQuestScreen({required this.level});

  @override
  _SelectQuestScreenState createState() => _SelectQuestScreenState();
}

class _SelectQuestScreenState extends State<SelectQuestScreen> {
  List<Question> questions = [];
  List<Question> filteredQuestions = [];
  List<Question> selectedQuestions = [];
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

  Future<void> _loadQuestionsFromFile() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final loadedQuestions = contents
            .split('\n')
            .where((line) => line.isNotEmpty)
            .map((line) => Question.deserialize(line))
            .toList();
        setState(() {
          questions = loadedQuestions;
          filteredQuestions =
              questions.where((q) => q.level == widget.level).toList();
        });
      }
    } catch (e) {
      // Manejo de errores
      print('Error loading questions: $e');
    }
  }

  void _toggleQuestionSelection(Question question, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedQuestions.add(question);
        print("test");
        print(questions.last.questionText);
        print(questions.last.correctOptionIndex);
      } else {
        selectedQuestions.remove(question);
      }
    });
  }

  void _startQuiz(BuildContext context) {
    if (selectedQuestions.length <= 10) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QuizScreen(questions: selectedQuestions),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can select up to 10 questions.')),
      );
    }
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
            appBar: AppBar(
              title: const Text('Select Questions'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredQuestions.length,
                    itemBuilder: (context, index) {
                      final question = filteredQuestions[index];
                      final isSelected = selectedQuestions.contains(question);
                      return CheckboxListTile(
                        title: Text(question.questionText),
                        value: isSelected,
                        onChanged: (bool? value) {
                          if (value != null) {
                            _toggleQuestionSelection(question, value);
                          }
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _startQuiz(context),
                  child: const Text('Start Quiz with Selected Questions'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
