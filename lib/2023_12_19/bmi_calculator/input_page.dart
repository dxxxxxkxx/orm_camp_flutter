import 'package:flutter/material.dart';
import 'package:orm_camp_flutter/2023_12_19/bmi_calculator/bmi_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _height;
  double? _weight;

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
                            builder: (final BuildContext context) =>
                                BmiPage(height: _height!, weight: _weight!),
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
