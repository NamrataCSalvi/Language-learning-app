import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SPoliteExpressionPage extends StatefulWidget {
  // ignore: use_super_parameters
  const SPoliteExpressionPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SPoliteExpressionPageState createState() => _SPoliteExpressionPageState();
}

class _SPoliteExpressionPageState extends State<SPoliteExpressionPage> {
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
        title: const Text('Polite Expressions in Spanish'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 13,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'English: ${[
                        'Please',
                        'Thank you',
                        'You\'re welcome',
                        'Excuse me',
                        'Pardon',
                        'I\'m sorry',
                        'Could you repeat, please?',
                        'Of course',
                        'May I...?',
                        'Could you bring me...?',
                        'Would you like...?',
                        'Let me help you',
                        'Sorry for the inconvenience',
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
                                'Por favor',
                                'Gracias',
                                'De nada',
                                'Disculpe',
                                'Perdón',
                                'Lo siento',
                                '¿Podría repetir, por favor?',
                                'Por supuesto',
                                '¿Me permite...?',
                                '¿Me podría traer...?',
                                '¿Le gustaría...? ',
                                'Permítame ayudarle',
                                'Disculpe la molestia',
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
                  if (_currentPageIndex < 12) {
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
    final asset = 'assets/audio/sp$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
