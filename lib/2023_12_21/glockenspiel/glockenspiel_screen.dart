import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class GlockenspielScreen extends StatefulWidget {
  const GlockenspielScreen({super.key});

  @override
  State<GlockenspielScreen> createState() => _GlockenspielScreenState();
}

class _GlockenspielScreenState extends State<GlockenspielScreen> {
  final Soundpool _soundpool;
  final List<int> _soundIds;
  bool _isLoaded;

  _GlockenspielScreenState()
      : _soundpool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault),
        _soundIds = [],
        _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _initSoundpool();
  }

  Future<void> _initSoundpool() async {
    final List<Future<int>> tasks = [
      _getSoundId(fileName: '01_C.mp3'),
      _getSoundId(fileName: '03_D.mp3'),
      _getSoundId(fileName: '05_E.mp3'),
      _getSoundId(fileName: '06_F.mp3'),
      _getSoundId(fileName: '08_G.mp3'),
      _getSoundId(fileName: '10_A.mp3'),
      _getSoundId(fileName: '12_B.mp3'),
      _getSoundId(fileName: '13_C.mp3')
    ];

    _soundIds.addAll(await Future.wait(tasks));

    setState(() {
      _isLoaded = true;
    });
  }

  Future<int> _getSoundId({required final String fileName}) async =>
      await rootBundle
          .load('assets/sound/$fileName')
          .then((final ByteData soundData) => _soundpool.load(soundData));

  Widget _keyboard({
    required final String note,
    required final Color color,
    required final double padding,
    required final int soundId,
  }) {
    return GestureDetector(
      onTap: () async {
        await _soundpool.play(soundId);
      },
      child: Container(
        width: 50.0,
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: padding),
        color: color,
        child: Center(
          child: Text(note, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return Scaffold(
      appBar: AppBar(title: const Text('글로켄슈필')),
      body: _isLoaded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _keyboard(
                  note: '도',
                  color: Colors.red,
                  padding: 16.0,
                  soundId: _soundIds[0],
                ),
                _keyboard(
                  note: '레',
                  color: Colors.orange,
                  padding: 24.0,
                  soundId: _soundIds[1],
                ),
                _keyboard(
                  note: '미',
                  color: Colors.yellow,
                  padding: 32.0,
                  soundId: _soundIds[2],
                ),
                _keyboard(
                  note: '파',
                  color: Colors.green,
                  padding: 40.0,
                  soundId: _soundIds[3],
                ),
                _keyboard(
                  note: '솔',
                  color: Colors.blue,
                  padding: 48.0,
                  soundId: _soundIds[4],
                ),
                _keyboard(
                  note: '라',
                  color: Colors.indigo,
                  padding: 56.0,
                  soundId: _soundIds[5],
                ),
                _keyboard(
                  note: '시',
                  color: Colors.purple,
                  padding: 64.0,
                  soundId: _soundIds[6],
                ),
                _keyboard(
                  note: '도',
                  color: Colors.red,
                  padding: 72.0,
                  soundId: _soundIds[7],
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
