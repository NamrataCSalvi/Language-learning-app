import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FPraisePage extends StatefulWidget {
  // ignore: use_super_parameters
  const FPraisePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FPraisePageState createState() => _FPraisePageState();
}

class _FPraisePageState extends State<FPraisePage> {
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
        title: const Text('Praises in French'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 14, // Adjusted to accommodate 14 praising expressions
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
                                'Vous êtes très intelligent(e)',
                                'Vous êtes très créatif(ve)',
                                'Vous êtes très talentueux(se)',
                                'Vous êtes très persévérant(e)',
                                'Vous êtes très inspirant(e)',
                                'Vous êtes très dévoué(e)',
                                'Vous avez beaucoup de connaissances',
                                'Vous êtes très ingénieux(se)',
                                'Vous êtes très compatissant(e)',
                                'Vous êtes très optimiste',
                                'Vous êtes très fiable',
                                'Vous êtes très motivé(e)',
                                'Vous êtes très travailleur(se)',
                                'Vous êtes très innovant(e)'
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
    final asset = 'assets/audio/fr$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
