import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // Import the collection package

class Game extends StatefulWidget {
  // ignore: use_super_parameters
  const Game({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<Map<String, dynamic>> puzzles = [
    {
      "correctOrder": ["Je", "voudrais", "commander"],
      "jumbled": ["commander", "Je", "voudrais"],
      "translation": "I would like to order",
      "translationEN":
          "I would like to order (English translation of the prompt)",
      "hint":
          "This is used at restaurants or shops to indicate you want to place an order."
    },
    {
      "correctOrder": ["Parlez-vous", "anglais"],
      "jumbled": ["anglais", "Parlez-vous"],
      "translation": "Do you speak English?",
      "translationEN":
          "Do you speak English? (Formal) (English translation of the prompt)",
      "hint": "This is a formal way to ask if someone speaks English."
    },
    {
      "correctOrder": ["À", "bientôt"],
      "jumbled": ["À", "bientôt"],
      "translation": "See you soon",
      "translationEN": "See you soon (English translation of the prompt)",
      "hint":
          "Used to say goodbye with the expectation of seeing someone again soon."
    },
    {
      "correctOrder": ["Excusez-moi", "où", "se trouvent", "les", "toilettes"],
      "jumbled": ["trouvent", "se", "les", "toilettes", "où", "Excusez-moi"],
      "translation": "Excuse me, where is the restroom?",
      "translationEN":
          "Excuse me, where is the restroom? (English translation of the prompt)",
      "hint": "A polite way to ask for directions to the bathroom."
    },
    {
      "correctOrder": ["C'est", "délicieux"],
      "jumbled": ["C'est", "délicieux"],
      "translation": "It's delicious",
      "translationEN": "It's delicious (English translation of the prompt)",
      "hint": "Used to compliment the food you're eating."
    },
    {
      "correctOrder": ["Merci", "beaucoup"],
      "jumbled": ["Merci", "beaucoup"],
      "translation": "Thank you very much",
      "translationEN":
          "Thank you very much (English translation of the prompt)",
      "hint": "A simple but essential phrase for expressing gratitude."
    },
    {
      "correctOrder": ["Ravi", "de", "vous", "rencontrer", "Enchanté"],
      "jumbled": ["Enchanté", "rencontrer", "de", "vous", "Ravi"],
      "translation": "Delighted to meet you",
      "translationEN":
          "Delighted to meet you (Literally: Enchanted, delighted to meet you) (English translation of the prompt)",
      "hint": "This is a formal way to say 'nice to meet you' in French."
    },
    {
      "correctOrder": ["Quel", "est", "votre", "nom"],
      "jumbled": ["Quel", "est", "votre", "nom"],
      "translation": "What is your name?",
      "translationEN":
          "What is your name? (Formal) (English translation of the prompt)",
      "hint": "This is a formal way to ask someone their name."
    },
    {
      "correctOrder": ["S'il vous plaît", "pouvez", "vous", "me", "passer"],
      "jumbled": ["S'il", "vous", "plaît", "pouvez", "me", "passer"],
      "translation": "Please, could you pass me...",
      "translationEN":
          "Please, could you pass me... (English translation of the prompt)",
      "hint": "This is a polite way to ask for something to be passed to you."
    },
    {
      "correctOrder": ["Excusez-moi", "où", "se trouvent", "les", "toilettes"],
      "jumbled": ["Excusez-moi", "où", "se", "trouvent", "les", "toilettes"],
      "translation": "Excuse me, where is the restroom?",
      "translationEN":
          "Excuse me, where is the restroom? (English translation of the prompt)",
      "hint": "A polite way to ask for directions to the bathroom."
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
            title: const Text('Correct!'),
            content: const Text('You got it right!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  goToNextPuzzle();
                },
                child: const Text('Next'),
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
            title: const Text('Incorrect'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Sorry, your answer is incorrect.'),
                const SizedBox(height: 10),
                const Text('The correct order is:'),
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
                child: const Text('Try Again'),
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
            title: const Text('Quiz Completed'),
            content: Text('Your total score: $score out of ${puzzles.length}'),
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
        title: const Text('French Phrase Puzzle'),
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
              puzzles[currentIndex]['translationEN'],
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 141, 108, 209),
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
                      currentOrder.add(puzzles[currentIndex]['jumbled'][index]);
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
              child: const Text('Check Answer'),
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
                child: const Text('Next Question'),
              ),
          ],
        ),
      ),
    );
  }
}
