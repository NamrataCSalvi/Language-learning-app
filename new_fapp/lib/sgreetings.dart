import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SGreetingsPage extends StatefulWidget {
  // ignore: use_super_parameters
  const SGreetingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SGreetingsPageState createState() => _SGreetingsPageState();
}

class _SGreetingsPageState extends State<SGreetingsPage> {
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
        title: const Text('Spanish Greetings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'English: ${[
                        'Hello',
                        'Good morning',
                        'Good afternoon',
                        'Good evening',
                        'How are you?',
                        'How are you doing?',
                        'Nice to meet you',
                        'Have a good day!',
                        'What\'s new?',
                        'How have you been?',
                        'Greetings',
                        'How\'s everything going?',
                        'What\'s up?',
                        'How\'s life treating you?',
                        'Hello, friend!'
                      ][index]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        _playAudio(index + 1);
                      },
                      child: Center(
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              [
                                'Hola',
                                'Buenos días',
                                'Buenas tardes',
                                'Buenas noches',
                                '¿Cómo estás?',
                                '¿Cómo te va?',
                                'Mucho gusto',
                                '¡Buen día!',
                                '¿Qué hay de nuevo?',
                                '¿Cómo lo has pasado?',
                                'Saludos',
                                '¿Cómo va todo?',
                                '¿Qué hubo?',
                                '¿Cómo le va la vida?',
                                '¡Hola, amigo!'
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
                  if (_currentPageIndex < 14) {
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
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _playAudio(int index) async {
    final asset = 'assets/audio/sg_$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
