import 'question.dart';

class QuestionManager {
  List<Question> _questions;

  QuestionManager(this._questions);

  // Añadir una nueva pregunta al banco
  void addQuestion(Question question) {
    _questions.add(question);
  }

  // Eliminar una pregunta del banco por su texto
  bool removeQuestion(String questionText) {
    int initialLength = _questions.length;
    _questions.removeWhere((q) => q.questionText == questionText);
    return _questions.length < initialLength;
  }

  // Obtener preguntas por nivel
  List<Question> getQuestionsByLevel(int level) {
    return _questions.where((q) => q.level == level).toList();
  }

  // Obtener todas las preguntas
  List<Question> getAllQuestions() {
    return _questions;
  }

  // Set new list of questions
  void setQuestions(List<Question> questions) {
    _questions = questions;
  }
}

// Ejemplo de inicialización de QuestionManager con preguntas existentes
final QuestionManager questionManager = QuestionManager(getQuestions());
