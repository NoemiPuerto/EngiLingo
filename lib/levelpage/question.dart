class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final int level;

  Question(
      {required this.questionText,
      required this.options,
      required this.correctOptionIndex,
      required this.level});

  String serialize() {
    return '$questionText|${options.join(',')}|$correctOptionIndex|$level';
  }

  static Question deserialize(String serialized) {
    final parts = serialized.split('|');
    final questionText = parts[0];
    final options = parts[1].split(',');
    final correctOptionIndex = int.parse(parts[2]);
    final level = int.parse(parts[3]);
    return Question(
      questionText: questionText,
      options: options,
      correctOptionIndex: correctOptionIndex,
      level: level,
    );
  }
}

List<Question> getQuestions() {
  List<Question> questions = [
    Question(
      questionText: 'How do you say "Cálculo Integral" in English?',
      options: [
        'Integral Calculation',
        'Differential Calculation',
        'Vector Calculation',
        'Algebraic Calculation'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ecuaciones Diferenciales" in English?',
      options: [
        'Integral Equations',
        'Differential Equations',
        'Algebraic Equations',
        'Linear Equations'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Mecánica de Fluidos" in English?',
      options: [
        'Fluid Mechanics',
        'Solid Mechanics',
        'Thermodynamics',
        'Fluid Dynamics'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Resistencia de Materiales" in English?',
      options: [
        'Material Resistance',
        'Strength of Materials',
        'Materials Science',
        'Material Engineering'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Circuitos Eléctricos" in English?',
      options: [
        'Electric Currents',
        'Electrical Circuits',
        'Electric Paths',
        'Electronics'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText:
          'How do you say "Programación Orientada a Objetos" in English?',
      options: [
        'Functional Programming',
        'Object-Oriented Programming',
        'Procedural Programming',
        'Logical Programming'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ingeniería de Software" in English?',
      options: [
        'Software Development',
        'Software Engineering',
        'Software Design',
        'Software Architecture'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText:
          'How do you say "Algoritmos y Estructuras de Datos" in English?',
      options: [
        'Algorithms and Data Structures',
        'Data and Algorithms',
        'Data Structures and Algorithms',
        'Algorithms and Data Management'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Redes de Computadoras" in English?',
      options: [
        'Computer Networks',
        'Network Computing',
        'Computing Networks',
        'Network Systems'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Base de Datos" in English?',
      options: ['Data Base', 'Database', 'Data Storage', 'Data System'],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Sistemas Operativos" in English?',
      options: [
        'Operating Systems',
        'System Operations',
        'Operating Mechanics',
        'Operational Systems'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Inteligencia Artificial" in English?',
      options: [
        'Artificial Intelligence',
        'Intelligent Automation',
        'Machine Learning',
        'Artificial Automation'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ingeniería de Control" in English?',
      options: [
        'Control Systems',
        'Control Engineering',
        'Engineering Control',
        'System Control'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText:
          'How do you say "Transistores y Amplificadores" in English?',
      options: [
        'Transistors and Amplifiers',
        'Transistors and Conductors',
        'Amplifiers and Resistors',
        'Transistors and Modulators'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText:
          'How do you say "Ingeniería de Telecomunicaciones" in English?',
      options: [
        'Communication Engineering',
        'Telecommunications Engineering',
        'Telecom Engineering',
        'Telecommunications Science'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Redes Inalámbricas" in English?',
      options: [
        'Wired Networks',
        'Wireless Networks',
        'Network Wireless',
        'Wireless Connections'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Procesamiento de Señales" in English?',
      options: [
        'Signal Processing',
        'Signal Handling',
        'Processing Signals',
        'Signal Analysis'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Microcontroladores" in English?',
      options: [
        'Microcomputers',
        'Microprocessors',
        'Microcontrollers',
        'Microcircuits'
      ],
      correctOptionIndex: 2,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Robótica" in English?',
      options: [
        'Robotics',
        'Robot Engineering',
        'Robotics Engineering',
        'Robot Mechanics'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ingeniería Mecánica" in English?',
      options: [
        'Mechanical Engineering',
        'Mechanics Engineering',
        'Machine Engineering',
        'Engineering Mechanics'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Análisis de Circuitos" in English?',
      options: [
        'Circuit Analysis',
        'Circuit Examination',
        'Circuit Breakdown',
        'Circuit Testing'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ingeniería Eléctrica" in English?',
      options: [
        'Electrical Engineering',
        'Electric Engineering',
        'Electronics Engineering',
        'Engineering Electricity'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText:
          'How do you say "Diseño Asistido por Computadora" in English?',
      options: [
        'Computer Aided Design',
        'Design by Computer Assistance',
        'Assisted Computer Design',
        'Computer Assisted Design'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Matemáticas Discretas" in English?',
      options: [
        'Discrete Mathematics',
        'Discrete Math',
        'Mathematics of Discreteness',
        'Discrete Calculus'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ingeniería Civil" in English?',
      options: [
        'Civil Construction',
        'Civil Engineering',
        'Civil Design',
        'Civic Engineering'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Teoría de Control" in English?',
      options: [
        'Control Theory',
        'Theory of Control',
        'Controlling Theory',
        'System Control Theory'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Simulación por Computadora" in English?',
      options: [
        'Simulation with Computers',
        'Computer Simulation',
        'Simulated Computing',
        'Computing Simulation'
      ],
      correctOptionIndex: 1,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Ingeniería de Software" in English?',
      options: [
        'Software Engineering',
        'Software Development',
        'Software Architecture',
        'Software Systems'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Minería de Datos" in English?',
      options: [
        'Data Mining',
        'Data Exploration',
        'Mining Data',
        'Data Processing'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
    Question(
      questionText: 'How do you say "Criptografía" in English?',
      options: [
        'Cryptography',
        'Crypto Analysis',
        'Cryptology',
        'Cryptographic Science'
      ],
      correctOptionIndex: 0,
      level: 1,
    ),
  ];
  return questions;
}
