import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SBasicPage extends StatelessWidget {
 // ignore: use_super_parameters
 SBasicPage({Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Números'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          final number = index + 1;
          return ElevatedButton(
            onPressed: () {
              _playAudio(number);
            },
            child: Text('$number'),
          );
        },
      ),
    );
  }

  Future<void> _playAudio(int number) async {
    final asset = 'number_$number';
    await _audioPlayer.setAsset('assets/audio/$asset.mp3');
    _audioPlayer.play();
  }
}
