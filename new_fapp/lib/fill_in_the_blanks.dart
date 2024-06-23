import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: SpanishFillInTheBlanks(),
  ));
}

class SpanishFillInTheBlanks extends StatefulWidget {
  // ignore: use_super_parameters
  const SpanishFillInTheBlanks({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpanishFillInTheBlanksState createState() => _SpanishFillInTheBlanksState();
}

class _SpanishFillInTheBlanksState extends State<SpanishFillInTheBlanks> {
  final TextEditingController _controller = TextEditingController();
  final List<String> sentences = [
    'El __ es rojo.',
    'Me gusta __ en el parque.',
    'Ella __ a su abuela.',
    'Voy a __ un libro.',
    'El perro __ en el jardín.'
  ];
  final List<String> answers = ['coche', 'pasear', 'visita', 'leer', 'juega'];
  int currentSentenceIndex = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill in the Blanks (Spanish)'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _resetGame();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
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
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  sentences[currentSentenceIndex],
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your answer here',
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  onSubmitted: (input) {
                    if (input.isNotEmpty) {
                      _checkAnswer(input);
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _checkAnswer(_controller.text);
                    }
                  },
                  child: const Text('Check Answer'),
                ),
                const SizedBox(height: 10), // Add space between buttons
                ElevatedButton(
                  onPressed: () {
                    if (currentSentenceIndex == sentences.length - 1) {
                      _showFinalScore();
                    } else {
                      _nextSentence();
                    }
                  },
                  child: Text(
                    currentSentenceIndex == sentences.length - 1
                        ? 'Finish'
                        : 'Next Sentence',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkAnswer(String input) {
    if (input.toLowerCase() == answers[currentSentenceIndex]) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correct Answer!')),
      );
      setState(() {
        score++; // Increment score only for correct answers
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect Answer. Try Again.')),
      );
    }
  }

  void _nextSentence() {
    setState(() {
      _controller.clear();
      currentSentenceIndex = (currentSentenceIndex + 1) % sentences.length;
    });
  }

  void _resetGame() {
    setState(() {
      _controller.clear();
      currentSentenceIndex = 0;
      score = 0;
    });
  }

  void _showFinalScore() {
    String feedback;
    if (score == sentences.length) {
      feedback = 'Great job! You got all the answers correct!';
    } else if (score >= 3) {
      feedback = 'Well done! You have a good grasp of the language, but there is room for improvement.';
    } else if (score >= 1) {
      feedback = 'Keep practicing! You have some basic knowledge, but there\'s more to learn.';
    } else {
      feedback = 'Keep practicing! You\'ll improve with more practice and study.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your final score is: $score/${sentences.length}'),
              const SizedBox(height: 8),
              Text(feedback),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }
}
