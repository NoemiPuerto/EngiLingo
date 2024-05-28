import 'package:flutter/material.dart';
import 'quiz.dart';
import 'quiz_manager.dart';
import 'select_quest.dart';
import 'question.dart'; // Importamos el archivo que contiene getQuestions

class HowScreen extends StatelessWidget {
  final int level;

  HowScreen({required this.level});

  void _startRandomQuiz(BuildContext context) {
    final questionManager = QuizManager(getQuestions());
    final questions = questionManager.getRandomQuestionsByLevel(7, level);

    if (questions.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QuizScreen(questions: questions),
        ),
      );
      print("test");
      print(questions.last.correctOptionIndex);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No questions available for this level.')),
      );
    }
  }

  void _selectQuestions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectQuestScreen(level: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectQuestions(context),
              child: const Text('Select Questions'),
            ),
            ElevatedButton(
              onPressed: () => _startRandomQuiz(context),
              child: const Text('Randomize'),
            ),
          ],
        ),
      ),
    );
  }
}
