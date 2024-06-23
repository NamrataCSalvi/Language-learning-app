import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FLettersPage extends StatelessWidget {
  // ignore: use_super_parameters
  FLettersPage({Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alphabets'),
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
          itemCount: 26,
          itemBuilder: (BuildContext context, int index) {
            final letter = String.fromCharCode(index + 97);
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
                    // ignore: unnecessary_string_interpolations
                    '$letter',
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

  Future<void> _playAudio(String letter) async {
     final letterIndex = letter.codeUnitAt(0) - 97 + 2;
     final asset = '$letterIndex';
    await _audioPlayer.setAsset('assets/audio/$asset.mp3');
    _audioPlayer.play();
  }
}
