import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Match createState() => _Match();
}

class _Match extends State<Match> {
  List<Map<String, dynamic>> pairs = [
    {"english": "Cat", "spanish": "Gato"},
    {"english": "Dog", "spanish": "Perro"},
    {"english": "Bird", "spanish": "Pájaro"},
    {"english": "Tree", "spanish": "Árbol"},
    {"english": "Car", "spanish": "Coche"},
    {"english": "Book", "spanish": "Libro"},
    {"english": "House", "spanish": "Casa"},
    {"english": "Chair", "spanish": "Silla"},
    {"english": "Table", "spanish": "Mesa"},
    {"english": "Sun", "spanish": "Sol"},
  ];

  int score = 0;
  int totalPairs = 10;
  List<Map<String, String>> selectedPairs = [];

  List<String> shuffledSpanishWords = [];

  @override
  void initState() {
    super.initState();
    // Shuffle the list of Spanish words
    shuffledSpanishWords =
        List<String>.from(pairs.map((pair) => pair['spanish'] as String))
          ..shuffle();
  }

  void checkPair(String word, String language) {
    if (selectedPairs.length == 2) return;

    setState(() {
      selectedPairs.add({'word': word, 'language': language});
      if (selectedPairs.length == 2) {
        if (_isMatched()) {
          score++;
          selectedPairs.clear();
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              selectedPairs.clear();
            });
          });
        }
        if (score == totalPairs) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('¡Enhorabuena!'),
                content: const Text('¡Has completado el juego!'),
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
    });
  }

  bool _isMatched() {
    if (selectedPairs.isEmpty) {
      return false;
    }

    final englishPair = selectedPairs.firstWhere(
      (pair) => pair['language'] == 'english',
      orElse: () => {},
    );
    final englishWord = englishPair['word'] as String;

    final spanishPair = selectedPairs.firstWhere(
      (pair) => pair['language'] == 'spanish',
      orElse: () => {},
    );
    final spanishWord = spanishPair['word'] as String;

    return englishWord.isNotEmpty &&
        spanishWord.isNotEmpty &&
        pairs.any(
          (pair) =>
              pair['english'] == englishWord && pair['spanish'] == spanishWord,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Pairs Game (Spanish)'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Puntuación: $score / $totalPairs',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: (pairs.length / 2).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildEnglishOption(index * 2),
                        _buildEnglishOption(index * 2 + 1),
                        _buildSpanishOption(index * 2),
                        _buildSpanishOption(index * 2 + 1),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnglishOption(int index) {
    final englishWord = pairs[index]["english"] as String;
    final isMatched = selectedPairs.any(
        (pair) => pair['word'] == englishWord && pair['language'] == 'english');
    return InkWell(
      onTap: () => checkPair(pairs[index]["english"], "english"),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isMatched ? Colors.deepPurpleAccent[100] : Colors.purple[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          englishWord,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isMatched ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSpanishOption(int index) {
    final spanishWord = shuffledSpanishWords[index];
    final isMatched = selectedPairs.any(
        (pair) => pair['word'] == spanishWord && pair['language'] == 'spanish');
    return InkWell(
      onTap: () => checkPair(spanishWord, "spanish"),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isMatched ? Colors.deepPurpleAccent[100] : Colors.pink[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          spanishWord,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isMatched ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Match(),
  ));
}
