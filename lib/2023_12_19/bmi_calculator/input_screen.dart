import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bmi_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _heightController;
  final TextEditingController _weightController;
  double? _height;
  double? _weight;

  _InputScreenState()
      : _formKey = GlobalKey(),
        _heightController = TextEditingController(),
        _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');

    if (height != null && weight != null) {
      _heightController.text = '$height';
      _weightController.text = '$weight';
    }
  }

  Future<void> _save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_height != null && _weight != null) {
      await prefs.setDouble('height', _height!);
      await prefs.setDouble('weight', _weight!);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('비만도 계산기')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
                controller: _heightController,
                validator: (final String? value) =>
                    (value ?? '').trim().isEmpty ? '키를 입력하세요' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,
                controller: _weightController,
                validator: (final String? value) =>
                    (value ?? '').trim().isEmpty ? '몸무게를 입력하세요' : null,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _height = double.tryParse(_heightController.text.trim());
                      _weight = double.tryParse(_weightController.text.trim());

                      if (_height != null && _weight != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BmiScreen(height: _height!, weight: _weight!),
                          ),
                        );

                        await _save();
                      }
                    }
                  },
                  child: const Text('결과'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
