import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class FBasicPage extends StatelessWidget {
  FBasicPage({super.key});

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Numbers'),
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