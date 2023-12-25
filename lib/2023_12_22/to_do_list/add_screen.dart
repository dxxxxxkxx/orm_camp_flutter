import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'to_do.dart';

class AddScreen extends StatefulWidget {
  final Box<ToDo> box;

  const AddScreen({super.key, required this.box});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _controller;

  _AddScreenState()
      : _formKey = GlobalKey(),
        _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추가'),
        actions: [
          IconButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await widget.box.add(
                    ToDo(dateTime: DateTime.now(), text: _controller.text),
                  );

                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '할 일',
            ),
            validator: (final String? value) =>
                (value ?? '').trim().isEmpty ? '할 일을 입력하세요' : null,
          ),
        ),
      ),
    );
  }
}
