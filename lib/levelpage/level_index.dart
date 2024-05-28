import 'package:flutter/material.dart';
import 'quiz.dart';
import 'quiz_manager.dart';
import 'question.dart';
import 'how.dart';
import 'manage_questions.dart';

class LevelIndexScreen extends StatelessWidget {
  const LevelIndexScreen({Key? key}) : super(key: key);

  void _showHowScreen(BuildContext context, int level) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HowScreen(level: level),
      ),
    );
  }

  void _startQuiz(BuildContext context, int level) {
    final questionManager = QuizManager(getQuestions());
    final questions = questionManager.getRandomQuestionsByLevel(7, level);

    if (questions.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QuizScreen(questions: questions),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No questions available for this level.')),
      );
    }
  }

  void _editQuestions(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditQuestionsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showHowScreen(context, 1),
              child: const Text('Level 1'),
            ),
            ElevatedButton(
              onPressed: () => _showHowScreen(context, 2),
              child: const Text('Level 2'),
            ),
            ElevatedButton(
              onPressed: () => _showHowScreen(context, 3),
              child: const Text('Level 3'),
            ),
            ElevatedButton(
              onPressed: () => _editQuestions(context),
              child: const Text('Edit Questions'),
            ),
          ],
        ),
      ),
    );
  }
}
