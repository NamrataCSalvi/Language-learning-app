import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // Import the collection package

class Game extends StatefulWidget {
   // ignore: use_super_parameters
  const Game({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpanishGameState createState() => _SpanishGameState();
}

class _SpanishGameState extends State<Game> {
  List<Map<String, dynamic>> puzzles = [
    {
      "correctOrder": ["Me", "gusta", "el", "café"],
      "jumbled": ["café", "gusta", "Me", "el"],
      "translation": "I like coffee",
      "hint": "This is a sentence expressing preference for coffee.",
    },
    
    {
    "correctOrder": ["Voy", "al", "supermercado", "comprar", "a", "comida"],
    "jumbled": ["comprar", "supermercado", "Voy", "a", "al", "comida"],
    "translation": "I'm going to the supermarket to buy food",
    "hint": "This is a sentence about going to the supermarket to buy groceries."
  },
  {
    "correctOrder": ["Los", "niños", "juegan", "en", "parque", "el"],
    "jumbled": ["en", "juegan", "parque", "el", "niños", "Los"],
    "translation": "The children play in the park",
    "hint": "This is a sentence about children playing outdoors."
  },
  {
    "correctOrder": ["La", "casa", "muy", "bonita", "es"],
    "jumbled": ["muy", "casa", "bonita", "es", "La"],
    "translation": "The house is very beautiful",
    "hint": "This is a sentence describing the beauty of a house."
  },
  {
    "correctOrder": ["El", "trabaja", "en", "oficina", "mi", "padre"],
    "jumbled": ["oficina", "trabaja", "padre", "en", "mi", "El"],
    "translation": "My father works in the office",
    "hint": "This is a sentence about someone's father working in an office."
  },
  {
    "correctOrder": ["Voy", "la", "cine", "al", "ver", "a", "película"],
    "jumbled": ["al", "película", "cine", "la", "Voy", "ver", "a"],
    "translation": "I'm going to the cinema to watch a movie",
    "hint": "This is a sentence about going to the cinema to watch a film."
  }
  ];

  int currentIndex = 0;
  List<String> currentOrder = [];
  int score = 0;

  void checkAnswer() {
    final listEquals = const ListEquality().equals;

    if (listEquals(currentOrder, puzzles[currentIndex]['correctOrder'])) {
      setState(() {
        score++;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Correcto!'),
            content: const Text('¡Lo has acertado!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  goToNextPuzzle();
                },
                child: const Text('Siguiente'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incorrecto'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Lo siento, tu respuesta es incorrecta.'),
                const SizedBox(height: 10),
                const Text('El orden correcto es:'),
                const SizedBox(height: 5),
                Text(
                  puzzles[currentIndex]['correctOrder'].join(' '),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentOrder.clear();
                  });
                },
                child: const Text('Intentar de Nuevo'),
              ),
            ],
          );
        },
      );
    }
  }

  void goToNextPuzzle() {
    if (currentIndex < puzzles.length - 1) {
      setState(() {
        currentIndex++;
        currentOrder.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content:
                Text('Your score: $score de ${puzzles.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spanish Phrase Puzzle'),
        backgroundColor: const Color.fromARGB(255, 141, 108, 209),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              puzzles[currentIndex]['translation'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              puzzles[currentIndex]['hint'],
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 141, 108, 209),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                currentOrder.length,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      currentOrder.removeAt(index);
                    });
                  },
                  child: Chip(
                    label: Text(
                      currentOrder[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color.fromARGB(255, 209, 189, 243),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                puzzles[currentIndex]['jumbled'].length,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      currentOrder
                          .add(puzzles[currentIndex]['jumbled'][index]);
                    });
                  },
                  child: Chip(
                    label: Text(
                      puzzles[currentIndex]['jumbled'][index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color.fromARGB(255, 175, 156, 207),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 141, 108, 209),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Comprobar Respuesta'),
            ),
            const SizedBox(height: 20),
            if (currentIndex < puzzles.length - 1)
              ElevatedButton(
                onPressed: goToNextPuzzle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 141, 108, 209),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Next'),
              ),
          ],
        ),
      ),
    );
  }
}
