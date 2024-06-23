import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: GuessTheWordPage(),
  ));
}

class GuessTheWordPage extends StatefulWidget {
  // ignore: use_super_parameters
  const GuessTheWordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GuessTheWordPageState createState() => _GuessTheWordPageState();
}

class _GuessTheWordPageState extends State<GuessTheWordPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answerClicked = false;

  final List<Question> questions = [
    Question(
      'assets/cafe.png',
      [
        Option('Café', isCorrect: true), // Correct answer: Coffee
        Option('Té'), // Option: Tea
        Option('Agua'), // Option: Water
        Option('Jugo'), // Option: Juice
      ],
    ),
    Question(
      'assets/chaise.png',
      [
        Option('Silla', isCorrect: true), // Correct answer: Chair
        Option('Mesa'), // Option: Table
        Option('Cama'), // Option: Bed
        Option('Sillón'), // Option: Armchair
      ],
    ),
    // Add more questions here
    Question(
      'assets/pomme.png',
      [
        Option('Manzana', isCorrect: true), // Correct answer: Apple
        Option('Naranja'), // Option: Orange
        Option('Plátano'), // Option: Banana
        Option('Fresa'), // Option: Strawberry
      ],
    ),
    Question(
      'assets/livre.png',
      [
        Option('Libro', isCorrect: true), // Correct answer: Book
        Option('Cuaderno'), // Option: Notebook
        Option('Pluma'), // Option: Pen
        Option('Borrador'), // Option: Eraser
      ],
    ),
    Question(
      'assets/bicycle.png',
      [
        Option('Carro'), // Correct answer: Car
        Option('Camión'), // Option: Truck
        Option('Motocicleta'), // Option: Motorcycle
        Option('Bicicleta', isCorrect: true), // Option: Bicycle
      ],
    ),
    Question(
      'assets/grass.png',
      [
        Option('Árbol'), // Correct answer: Tree
        Option('Flor'), // Option: Flower
        Option('Planta'), // Option: Plant
        Option('Hierba', isCorrect: true), // Option: Grass
      ],
    ),
    Question(
      'assets/fly.png',
      [
        Option('Mariposa', isCorrect: true), // Correct answer: Butterfly
        Option('Mosca'), // Option: Fly
        Option('Abeja'), // Option: Bee
        Option('Libélula'), // Option: Dragonfly
      ],
    ),
    Question(
      'assets/hat.png',
      [
        Option('Sombrero', isCorrect: true), // Correct answer: Hat
        Option('Gorra'), // Option: Baseball cap
        Option('Boina'), // Option: Beret
        Option('Casco'), // Option: Helmet
      ],
    ),
    // Add more questions here
    Question(
      'assets/ring.png',
      [
        Option('Anillo', isCorrect: true), // Correct answer: Ring
        Option('Pulsera'), // Option: Bracelet
        Option('Collar'), // Option: Necklace
        Option('Aro'), // Option: Earring
      ],
    ),
    Question(
      'assets/pot.png',
      [
        Option('Maceta', isCorrect: true), // Correct answer: Flowerpot
        Option('Flor'), // Option: Flower
        Option('Planta'), // Option: Plant
        Option('Jardín'), // Option: Garden
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina la Palabra'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.emoji_events),
              label: Text('Puntuación: $score'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(237, 219, 240, 1),
              Color.fromARGB(255, 153, 68, 189)
            ], // Shades of purple
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: currentQuestionIndex < questions.length
                ? _buildQuestionPage(questions[currentQuestionIndex])
                : _buildResultPage(),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(Question question) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display Image
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            question.imagePath,
            width: 150.0,
            height: 150.0,
          ),
        ),
        const SizedBox(height: 20.0),
        // Display Options using Clickable Buttons
        Column(
          children: List.generate(
            question.options.length,
            (index) {
              final option = question.options[index];
              bool isCorrect = option.isCorrect;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (!answerClicked) {
                      _checkAnswer(option);
                    } else {
                      if (!isCorrect) {
                        _checkAnswer(option);
                      }
                    }
                  });
                },
                child: Container(
                  width: 200, // Adjust width as needed
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color: isCorrect && answerClicked
                        ? Colors.green
                        : Colors.transparent,
                    border: Border.all(
                      color: answerClicked && !isCorrect
                          ? Colors.red
                          : Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      option.text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: answerClicked && !isCorrect
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: answerClicked ? _nextQuestion : null,
          child: const Text('Siguiente Pregunta'),
        ),
      ],
    );
  }

  Widget _buildResultPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¡Felicidades! Tu Puntuación: $score / ${questions.length}',
            style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          // Add any additional UI elements or messages for the result page
          // ...
        ],
      ),
    );
  }

  void _checkAnswer(Option selectedOption) {
    setState(() {
      answerClicked = true;
      if (selectedOption.isCorrect) {
        // Correct Answer
        score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      answerClicked = false;
      currentQuestionIndex++;
    });
  }
}

class Question {
  final String imagePath;
  final List<Option> options;

  Question(this.imagePath, this.options);
}

class Option {
  final String text;
  final bool isCorrect;

  Option(this.text, {this.isCorrect = false});
}
