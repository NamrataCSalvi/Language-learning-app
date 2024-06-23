import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  // ignore: use_super_parameters
  const Match({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  List<Map<String, dynamic>> pairs = [
    {"english": "Cat", "french": "Chat"},
    {"english": "Dog", "french": "Chien"},
    {"english": "Bird", "french": "Oiseau"},
    {"english": "Tree", "french": "Arbre"},
    {"english": "Car", "french": "Voiture"},
    {"english": "Book", "french": "Livre"},
    {"english": "House", "french": "Maison"},
    {"english": "Chair", "french": "Chaise"},
    {"english": "Table", "french": "Table"},
    {"english": "Sun", "french": "Soleil"},
  ];

  int score = 0;
  int totalPairs = 10;
  List<Map<String, String>> selectedPairs = [];

  List<String> shuffledFrenchWords = [];

  @override
  void initState() {
    super.initState();
    // Shuffle the list of French words
    shuffledFrenchWords =
        List<String>.from(pairs.map((pair) => pair['french'] as String))
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
                title: const Text('Congratulations!'),
                content: const Text('You have completed the game!'),
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

    final frenchPair = selectedPairs.firstWhere(
      (pair) => pair['language'] == 'french',
      orElse: () => {},
    );
    final frenchWord = frenchPair['word'] as String;

    return englishWord.isNotEmpty &&
        frenchWord.isNotEmpty &&
        pairs.any(
          (pair) =>
              pair['english'] == englishWord && pair['french'] == frenchWord,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Pairs Game'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(
              'Score: $score / $totalPairs',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            const SizedBox(height: 15),
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
                        _buildFrenchOption(index * 2),
                        _buildFrenchOption(index * 2 + 1),
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
        width: 75,
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

  Widget _buildFrenchOption(int index) {
    final frenchWord = shuffledFrenchWords[index];
    final isMatched = selectedPairs.any(
        (pair) => pair['word'] == frenchWord && pair['language'] == 'french');
    return InkWell(
      onTap: () => checkPair(frenchWord, "french"),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 75,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isMatched ? Colors.deepPurpleAccent[100] : Colors.pink[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          frenchWord,
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
