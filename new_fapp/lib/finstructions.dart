import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FInstructionsPage extends StatefulWidget {
  // ignore: use_super_parameters
  const FInstructionsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FInstructionsPageState createState() => _FInstructionsPageState();
}

class _FInstructionsPageState extends State<FInstructionsPage> {
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
        title: const Text('French Instructions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 14, // Adjusted to accommodate 14 instructions
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
                        'Stop here',
                        'Watch out for pedestrians',
                        'Keep to the right lane',
                        'Cross the street',
                        'Follow the signs',
                        'Check the rearview mirror',
                        'Slow down',
                        'Change lanes',
                        'Proceed with caution',
                        'Follow the speed limit'
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
                                'Tournez à droite',
                                'Tournez à gauche',
                                'Allez tout droit',
                                'Prenez la prochaine sortie à droite',
                                'Arrêtez-vous ici',
                                'Attention aux piétons',
                                'Restez sur la voie de droite',
                                'Traversez la rue',
                                'Suivez les panneaux',
                                'Vérifiez le rétroviseur',
                                'Ralentissez',
                                'Changez de voie',
                                'Procédez avec prudence',
                                'Respectez la limite de vitesse'
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
    final asset = 'assets/audio/fi$index.mp3';
    await _audioPlayer.setAsset(asset);
    _audioPlayer.play();
  }
}
