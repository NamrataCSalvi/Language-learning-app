import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FGreetingsPage extends StatefulWidget {
  // ignore: use_super_parameters
  const FGreetingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FGreetingsPageState createState() => _FGreetingsPageState();
}

class _FGreetingsPageState extends State<FGreetingsPage> {
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
        title: const Text('French Greetings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 14, // Adjusted to accommodate 14 greetings
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'English: ${[
                        'Hello',
                        'Hi',
                        'Good evening',
                        'Good night',
                        'Good morning',
                        'How are you?',
                        'Nice to meet you',
                        'See you later',
                        'Have a nice day',
                        'Take care',
                        'Welcome',
                        'Congratulations',
                        'Best wishes',
                        'Farewell'
                      ][index]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        _playAudio(index + 1);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              [
                                'Bonjour',
                                'Salut',
                                'Bonsoir',
                                'Bonne nuit',
                                'Bonjour',
                                'Comment ça va?',
                                'Enchanté(e)',
                                'À plus tard',
                                'Bonne journée',
                                'Prends soin de toi',
                                'Bienvenue',
                                'Félicitations',
                                'Meilleurs vœux',
                                'Adieu'
                              ][index],
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Icon(
                              Icons.volume_up,
                              size: 30,
                              color: Colors.pink,
                            ),
                          ],
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
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _playAudio(int index) async {
    final asset = 'assets/audio/fg$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
