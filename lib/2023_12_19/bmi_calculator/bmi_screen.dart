import 'package:flutter/material.dart';

class BmiScreen extends StatelessWidget {
  final double _height;
  final double _weight;

  const BmiScreen({super.key, required double height, required double weight})
      : _weight = weight,
        _height = height;

  String _calculateBmi(final double bmi) {
    String result = '저체중';

    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }

    return result;
  }

  Widget _buildIcon({required final double bmi}) {
    Icon result = const Icon(Icons.sentiment_dissatisfied,
        color: Colors.orange, size: 100.0);

    if (bmi >= 23) {
      result = const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100.0,
      );
    } else if (bmi >= 18.5) {
      result = const Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100.0,
      );
    }

    return result;
  }

  @override
  Widget build(final BuildContext context) {
    final double bmi = _weight / ((_height / 100) * (_height / 100));

    return Scaffold(
      appBar: AppBar(title: const Text('비만도 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_calculateBmi(bmi), style: const TextStyle(fontSize: 36.0)),
            const SizedBox(height: 16.0),
            _buildIcon(bmi: bmi)
          ],
        ),
      ),
    );
  }
}
