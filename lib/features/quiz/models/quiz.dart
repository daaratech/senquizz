import 'package:equatable/equatable.dart';

enum Level { easy, medium, hard, veryHard }

class Question extends Equatable {
  final String name;
  final List<String> answers;
  final int indexOfRightAnswer;

  const Question({
    required this.name,
    required this.answers,
    required this.indexOfRightAnswer,
  });

  Question copyWith(
      {String? name, required List<String> answers, int? indexOfRightAnswer}) {
    return Question(
        name: name ?? this.name,
        answers: answers,
        indexOfRightAnswer: indexOfRightAnswer ?? this.indexOfRightAnswer);
  }

  @override
  List<Object> get props => [name, answers, indexOfRightAnswer];
  Question.empty()
      : name = '',
        answers = [],
        indexOfRightAnswer = -1;
}

class Quiz extends Equatable {
  final String? uuid;
  final String name;
  final Level level;
  final String description;
  final List<String> categories;
  final int numberOfQuestions;
  final int duration;
  final List<Question> questions;

  const Quiz({
    this.uuid,
    required this.name,
    required this.level,
    required this.description,
    required this.categories,
    required this.numberOfQuestions,
    required this.duration,
    this.questions = const [],
  });
  @override
  List<Object> get props => [
        name,
        level,
        description,
        categories,
        numberOfQuestions,
        duration,
        questions
      ];

  Quiz copyWith({
    String? name,
    Level? level,
    String? description,
    List<String>? categories,
    int? numberOfQuestions,
    int? duration,
    List<Question>? questions,
    String? uuid,
  }) {
    return Quiz(
      name: name ?? this.name,
      level: level ?? this.level,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      duration: duration ?? this.duration,
      questions: questions ?? this.questions,
      uuid: uuid ?? this.uuid,
    );
  }

  static Quiz empty() {
    return const Quiz(
      name: '',
      level: Level.easy,
      description: '',
      categories: [],
      numberOfQuestions: 1,
      duration: 1,
    );
  }
}

final List<Quiz> dummyQuizzes = [
  const Quiz(
    uuid: '1',
    name: 'Math Quiz',
    level: Level.easy,
    description: 'A quiz about basic math concepts.',
    categories: ['Math', 'Science'],
    numberOfQuestions: 5,
    duration: 10,
    questions: [
      Question(
        name: 'What is 2 + 2?',
        answers: ['3', '4', '5', '6'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'What is 3 * 3?',
        answers: ['6', '7', '8', '9'],
        indexOfRightAnswer: 3,
      ),
      Question(
        name: 'What is 10 / 2?',
        answers: ['2', '3', '4', '5'],
        indexOfRightAnswer: 3,
      ),
      Question(
        name: 'What is 5 - 3?',
        answers: ['1', '2', '3', '4'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'What is 7 + 2?',
        answers: ['8', '9', '10', '11'],
        indexOfRightAnswer: 1,
      ),
    ],
  ),
  const Quiz(
    uuid: '2',
    name: 'History Quiz',
    level: Level.medium,
    description: 'A quiz about world history.',
    categories: ['History'],
    numberOfQuestions: 3,
    duration: 15,
    questions: [
      Question(
        name: 'Who was the first president of the United States?',
        answers: [
          'George Washington',
          'Thomas Jefferson',
          'Abraham Lincoln',
          'John Adams'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'In which year did World War II end?',
        answers: ['1942', '1945', '1948', '1950'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'Who discovered America?',
        answers: [
          'Christopher Columbus',
          'Leif Erikson',
          'Amerigo Vespucci',
          'Ferdinand Magellan'
        ],
        indexOfRightAnswer: 0,
      ),
    ],
  ),
  const Quiz(
    uuid: '3',
    name: 'Science Quiz',
    level: Level.hard,
    description: 'A quiz about general science knowledge.',
    categories: ['Science'],
    numberOfQuestions: 4,
    duration: 20,
    questions: [
      Question(
        name: 'What is the chemical symbol for water?',
        answers: ['H2O', 'O2', 'CO2', 'NaCl'],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'What planet is known as the Red Planet?',
        answers: ['Earth', 'Mars', 'Jupiter', 'Saturn'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'What is the speed of light?',
        answers: [
          '300,000 km/s',
          '150,000 km/s',
          '450,000 km/s',
          '600,000 km/s'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'What is the powerhouse of the cell?',
        answers: ['Nucleus', 'Mitochondria', 'Ribosome', 'Golgi apparatus'],
        indexOfRightAnswer: 1,
      ),
    ],
  ),
  const Quiz(
    uuid: '4',
    name: 'Geography Quiz',
    level: Level.veryHard,
    description: 'A quiz about world geography.',
    categories: ['Geography'],
    numberOfQuestions: 2,
    duration: 5,
    questions: [
      Question(
        name: 'What is the capital of Australia?',
        answers: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        indexOfRightAnswer: 2,
      ),
      Question(
        name: 'Which is the largest ocean on Earth?',
        answers: [
          'Atlantic Ocean',
          'Indian Ocean',
          'Arctic Ocean',
          'Pacific Ocean'
        ],
        indexOfRightAnswer: 3,
      ),
    ],
  ),
  const Quiz(
    uuid: '5',
    name: 'Literature Quiz',
    level: Level.medium,
    description: 'A quiz about famous literature and authors.',
    categories: ['Literature'],
    numberOfQuestions: 4,
    duration: 12,
    questions: [
      Question(
        name: 'Who wrote "1984"?',
        answers: [
          'George Orwell',
          'Aldous Huxley',
          'Ray Bradbury',
          'J.K. Rowling'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'Which novel begins with "Call me Ishmael"?',
        answers: [
          'Moby Dick',
          'The Great Gatsby',
          'War and Peace',
          'Pride and Prejudice'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'Who is the author of "Pride and Prejudice"?',
        answers: [
          'Jane Austen',
          'Charlotte Bronte',
          'Emily Bronte',
          'Mary Shelley'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'Which book is set in the fictional town of Maycomb, Alabama?',
        answers: [
          'To Kill a Mockingbird',
          'The Catcher in the Rye',
          'The Grapes of Wrath',
          'Of Mice and Men'
        ],
        indexOfRightAnswer: 0,
      ),
    ],
  ),
  const Quiz(
    uuid: '6',
    name: 'Sports Quiz',
    level: Level.easy,
    description: 'A quiz about various sports and athletes.',
    categories: ['Sports'],
    numberOfQuestions: 3,
    duration: 8,
    questions: [
      Question(
        name: 'Which country won the FIFA World Cup in 2018?',
        answers: ['Brazil', 'Germany', 'France', 'Argentina'],
        indexOfRightAnswer: 2,
      ),
      Question(
        name:
            'Who holds the record for the most home runs in a single MLB season?',
        answers: ['Babe Ruth', 'Barry Bonds', 'Hank Aaron', 'Mark McGwire'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'In which sport would you perform a slam dunk?',
        answers: ['Basketball', 'Tennis', 'Football', 'Baseball'],
        indexOfRightAnswer: 0,
      ),
    ],
  ),
  const Quiz(
    uuid: '7',
    name: 'Music Quiz',
    level: Level.hard,
    description: 'A quiz about music history and famous musicians.',
    categories: ['Music'],
    numberOfQuestions: 5,
    duration: 15,
    questions: [
      Question(
        name: 'Who is known as the "King of Pop"?',
        answers: ['Elvis Presley', 'Michael Jackson', 'Prince', 'Madonna'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'Which band released the album "Abbey Road"?',
        answers: [
          'The Beatles',
          'The Rolling Stones',
          'Pink Floyd',
          'Led Zeppelin'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'Who composed the Four Seasons?',
        answers: [
          'Johann Sebastian Bach',
          'Ludwig van Beethoven',
          'Antonio Vivaldi',
          'Wolfgang Amadeus Mozart'
        ],
        indexOfRightAnswer: 2,
      ),
      Question(
        name: 'Which singer is known for the hit song "Rolling in the Deep"?',
        answers: ['Adele', 'Beyoncé', 'Taylor Swift', 'Rihanna'],
        indexOfRightAnswer: 0,
      ),
      Question(
        name: 'Which instrument does Yo-Yo Ma play?',
        answers: ['Violin', 'Piano', 'Cello', 'Guitar'],
        indexOfRightAnswer: 2,
      ),
    ],
  ),
  const Quiz(
    uuid: '8',
    name: 'Technology Quiz',
    level: Level.veryHard,
    description: 'A quiz about technology and computer science.',
    categories: ['Technology'],
    numberOfQuestions: 4,
    duration: 10,
    questions: [
      Question(
        name: 'Who is known as the father of computers?',
        answers: ['Alan Turing', 'Charles Babbage', 'Bill Gates', 'Steve Jobs'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name: 'What does HTTP stand for?',
        answers: [
          'HyperText Transfer Protocol',
          'HyperText Transmission Protocol',
          'HyperText Transfer Program',
          'HyperText Transmission Program'
        ],
        indexOfRightAnswer: 0,
      ),
      Question(
        name:
            'Which programming language is known as the backbone of web development?',
        answers: ['Python', 'JavaScript', 'Java', 'C++'],
        indexOfRightAnswer: 1,
      ),
      Question(
        name:
            'What is the name of the first electronic general-purpose computer?',
        answers: ['ENIAC', 'UNIVAC', 'IBM 701', 'Apple I'],
        indexOfRightAnswer: 0,
      ),
    ],
  ),
];
