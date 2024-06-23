import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SPraisePage extends StatefulWidget {
  // ignore: use_super_parameters
  const SPraisePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SPraisePageState createState() => _SPraisePageState();
}

class _SPraisePageState extends State<SPraisePage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elogios en Español'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 14,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'English: You are very ${[
                        'intelligent',
                        'creative',
                        'talented',
                        'persistent',
                        'inspiring',
                        'dedicated',
                        'knowledgeable',
                        'resourceful',
                        'compassionate',
                        'optimistic',
                        'reliable',
                        'motivated',
                        'hardworking',
                        'innovative'
                      ][index]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        _playAudio(index + 1); // Adjust index to match the correct file
                      },
                      child: Center(
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              [
                                '¡Eres muy inteligente!',
                                '¡Eres muy creativo!',
                                '¡Eres muy talentoso!',
                                '¡Eres muy persistente!',
                                '¡Eres muy valiente!',
                                '¡Excelente trabajo!',
                                '¡Qué gran logro!',
                                '¡Eres una inspiración!',
                                '¡Qué amable eres!',
                                '¡Eres una persona maravillosa!',
                                '¡Eres un ejemplo a seguir!',
                                '¡Estoy orgulloso/a de ti!',
                                '¡Eres una persona excepcional!'
                              ][index],
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (_currentPageIndex > 0) {
                    setState(() {
                      _currentPageIndex--;
                    });
                    _pageController.animateToPage(
                      _currentPageIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_currentPageIndex < 13) {
                    setState(() {
                      _currentPageIndex++;
                    });
                    _pageController.animateToPage(
                      _currentPageIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              ElevatedButton( // Button to play audio
                onPressed: () {
                  _playAudio(_currentPageIndex + 1); // Adjust index to match the correct file
                },
                child: const Text('Play Audio'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _playAudio(int index) async {
    final asset = 'assets/audio/spr$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
