import 'package:flutter/material.dart';
import 'question.dart';
import '../homepage.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;

  QuizScreen({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late List<Question> _randomQuestions; // Quitamos el modificador 'late' aquí

  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int> _shuffledIndices = [];
  late int _shuffledCorrectIndex;

  @override
  void initState() {
    super.initState();
    _randomQuestions = widget.questions; // Inicializamos _randomQuestions aquí
    _shuffleOptions();
  }

  void _shuffleOptions() {
    _shuffledIndices = List<int>.generate(
        _randomQuestions[_currentQuestionIndex].options.length,
        (index) => index);
    // _shuffledIndices.shuffle();

    // Buscamos la respuesta correcta en la lista original de opciones
    int correctOptionIndex =
        _randomQuestions[_currentQuestionIndex].correctOptionIndex;

    // Obtenemos el índice de la respuesta correcta en la lista mezclada
    _shuffledCorrectIndex = _shuffledIndices.indexOf(correctOptionIndex);
  }

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _shuffledCorrectIndex) {
      _score++;
      _showFeedbackDialog(true);
    } else {
      _showFeedbackDialog(false);
    }
  }

  void _showFeedbackDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Wrong!'),
        content: Text(isCorrect
            ? 'Good job! That is the correct answer.'
            : 'Oops! The correct answer was ${_randomQuestions[_currentQuestionIndex].options[_randomQuestions[_currentQuestionIndex].correctOptionIndex]}.'),
        actions: [
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _nextQuestion();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(55),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _randomQuestions.length - 1) {
        _currentQuestionIndex++;
        _shuffleOptions();
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FinalScoreScreen(score: _score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: const Color.fromARGB(255, 27, 90, 190),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_randomQuestions.length}',
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 30),
            Text(
              _randomQuestions[_currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ..._shuffledIndices.map(
              (idx) {
                String text =
                    _randomQuestions[_currentQuestionIndex].options[idx];

                return ElevatedButton(
                  onPressed: () => _answerQuestion(idx),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FinalScoreScreen extends StatelessWidget {
  final int score;

  const FinalScoreScreen({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Score'),
        backgroundColor: const Color.fromARGB(255, 27, 90, 190),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/7',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
