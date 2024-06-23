import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SLettersPage extends StatelessWidget {
  // ignore: use_super_parameters
  SLettersPage({Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alfabeto Español'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blueAccent.shade100],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: 27, // Including 'ñ'
          itemBuilder: (BuildContext context, int index) {
            final letter = _getSpanishLetter(index);
            return GestureDetector(
              onTap: () => _playAudio(letter),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.indigo.shade600, Colors.indigo.shade400],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.shade600.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    // Displaying letter or 'ñ'
                    index == 26 ? 'ñ' : letter,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getSpanishLetter(int index) {
    // Spanish alphabet excluding 'ñ'
    const spanishAlphabet = 'abcdefghijklmnñopqrstuvwxyz';
    return spanishAlphabet[index];
  }

  Future<void> _playAudio(String letter) async {
    final letterIndex = letter == 'ñ' ? 15 : letter.codeUnitAt(0) - 97 + 2;
    final asset = '$letterIndex';
    await _audioPlayer.setAsset('assets/audio/$asset.mp3');
    _audioPlayer.play();
  }
}
