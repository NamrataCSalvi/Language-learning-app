import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FrenchNumbersPage extends StatelessWidget {
  // ignore: use_super_parameters
  FrenchNumbersPage({Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Numbers in French'),
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
        child: SizedBox( // Wrap with SizedBox
          height: MediaQuery.of(context).size.height - kToolbarHeight - 40, // Adjust height as necessary
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              final number = index + 1;
              return GestureDetector(
                onTap: () => _playAudio(number),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.indigo.shade600, Colors.indigo.shade400],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.shade600.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$number',
                        style: const TextStyle(
                          fontSize:18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        _getFrenchNumberSpelling(number),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getFrenchNumberSpelling(int number) {
    switch (number) {
      case 1:
        return 'un';
      case 2:
        return 'deux';
      case 3:
        return 'trois';
      case 4:
        return 'quatre';
      case 5:
        return 'cinq';
      case 6:
        return 'six';
      case 7:
        return 'sept';
      case 8:
        return 'huit';
      case 9:
       return 'neuf';
      case 10:
        return 'dix';
      default:
        return '';
    }
  }

  Future<void> _playAudio(int number) async {
    final asset = 'number_$number';
    await _audioPlayer.setAsset('assets/audio/$asset.mp3');
    _audioPlayer.play();
  }
}