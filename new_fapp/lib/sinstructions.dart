import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SInstructionsPage extends StatefulWidget {
  // ignore: use_super_parameters
  const SInstructionsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SInstructionsPageState createState() => _SInstructionsPageState();
}

class _SInstructionsPageState extends State<SInstructionsPage> {
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
        title: const Text('Instructions in Spanish'),
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
                        'Turn right',
                        'Turn left',
                        'Go straight',
                        'Take the next exit right',
                        'Raise your hand',
                        'Sit down',
                        'Listen',
                        'Speak more slowly, please',
                        'Open the book to page five',
                        'Write your name on the board',
                        'Read the text out loud',
                        'Be quiet',
                        'Do it yourself',
                        'Follow the instructions',
                        'Repeat after me',
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
                                'Gira a la derecha',
                                'Gira a la izquierda',
                                'Sigue derecho',
                                'Toma la próxima salida a la derecha',
                                'Levanta la mano',
                                'Siéntate',
                                'Escucha',
                                'Habla más despacio, por favor',
                                'Abre el libro en la página cinco',
                                'Escribe tu nombre en la pizarra',
                                'Lee el texto en voz alta',
                                'Guarda silencio',
                                'Hazlo tú mismo',
                                'Sigue las instrucciones',
                                'Repite después de mí',
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
    final asset = 'assets/audio/si_$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
