import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Timer _timer;
  final List<String> _lapTimes;
  int _time;
  bool _isRunning;

  _StopwatchScreenState()
      : _lapTimes = [],
        _time = 0,
        _isRunning = false;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _clickButton() {
    _isRunning = !_isRunning;
    _isRunning ? _start() : _pause();
  }

  void _start() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (_) => setState(() {
        _time++;
      }),
    );
  }

  void _pause() {
    _timer.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer.cancel();
    _lapTimes.clear();
    _time = 0;
  }

  void _recordLapTime(final String time) {
    _lapTimes.insert(0, '${_lapTimes.length + 1}등: $time');
  }

  @override
  Widget build(BuildContext context) {
    final int sec = _time ~/ 100;
    final String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(title: const Text('스톱워치')),
      body: Column(
        children: [
          const SizedBox(height: 56.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$sec', style: const TextStyle(fontSize: 120.0)),
              const SizedBox(width: 12.0),
              Text(hundredth, style: const TextStyle(fontSize: 32.0))
            ],
          ),
          const SizedBox(height: 56.0),
          SizedBox(
            width: 160.0,
            height: 240.0,
            child: ListView(
              children: _lapTimes
                  .map((final String record) => Center(
                        child: Text(
                          record,
                          style: const TextStyle(fontSize: 24.0),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () => setState(() {
                  _reset();
                }),
                backgroundColor: Colors.orange,
                child: const Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () => setState(() {
                  _clickButton();
                }),
                child: _isRunning
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                  onPressed: () => setState(() {
                        _recordLapTime('$sec.$hundredth');
                      }),
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add))
            ],
          ),
          const SizedBox(height: 56.0)
        ],
      ),
    );
  }
}
