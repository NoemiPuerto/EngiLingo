import 'dart:math';
import 'question.dart';

class QuizManager {
  final List<Question> _questions;

  QuizManager(this._questions);

  List<Question> getRandomQuestionsByLevel(int count, int level) {
    List<Question> filteredQuestions =
        _questions.where((q) => q.level == level).toList();
    return getRandomQuestionsFromList(count, filteredQuestions);
  }

  List<Question> getRandomQuestionsFromList(
      int count, List<Question> questions) {
    List<Question> randomQuestions = [];

    // Obtener una lista aleatoria de índices únicos
    List<int> randomIndices = _getRandomIndices(count, questions.length);

    // Seleccionar preguntas aleatorias usando los índices
    randomIndices.forEach((index) {
      randomQuestions.add(questions[index]);
    });

    return randomQuestions;
  }

  List<int> _getRandomIndices(int count, int max) {
    List<int> indices = [];
    Random random = Random();

    // Asegurarse de que el número de índices no sea mayor que el número total de preguntas
    count = min(count, max);

    while (indices.length < count) {
      int index = random.nextInt(max);

      // Añadir el índice solo si no está ya en la lista
      if (!indices.contains(index)) {
        indices.add(index);
      }
    }

    return indices;
  }
}
