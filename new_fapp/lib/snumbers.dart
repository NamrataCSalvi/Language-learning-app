import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SpanishNumbersPage extends StatelessWidget {
  // ignore: use_super_parameters
   SpanishNumbersPage({Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Números en Español'),
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight - 40,
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
                        _getSpanishNumberSpelling(number),
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

  String _getSpanishNumberSpelling(int number) {
    switch (number) {
      case 1:
        return 'uno';
      case 2:
        return 'dos';
      case 3:
        return 'tres';
      case 4:
        return 'cuatro';
      case 5:
        return 'cinco';
      case 6:
        return 'seis';
      case 7:
        return 'siete';
      case 8:
        return 'ocho';
      case 9:
        return 'nueve';
      case 10:
        return 'diez';
      default:
        return '';
    }
  }

  Future<void> _playAudio(int number) async {
    final asset = 'sb_number$number';
    await _audioPlayer.setAsset('assets/audio/$asset.mp3');
    _audioPlayer.play();
  }
}
