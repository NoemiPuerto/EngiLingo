import 'package:flutter/material.dart';
import 'quiz.dart';
import 'quiz_manager.dart';
import 'question.dart';

class LevelIndexScreen extends StatelessWidget {
  const LevelIndexScreen({Key? key}) : super(key: key);

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
        SnackBar(content: Text('No questions available for this level.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _startQuiz(context, 1),
              child: Text('Level 1'),
            ),
            ElevatedButton(
              onPressed: () => _startQuiz(context, 2),
              child: Text('Level 2'),
            ),
            ElevatedButton(
              onPressed: () => _startQuiz(context, 3),
              child: Text('Level 3'),
            ),
          ],
        ),
      ),
    );
  }
}
