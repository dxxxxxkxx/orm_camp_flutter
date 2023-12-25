import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'to_do.dart';

class ToDoListView extends StatelessWidget {
  final Box<ToDo> box;

  const ToDoListView({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: box.values
          .map(
            (final ToDo toDo) => ListTile(
              title: Text(DateFormat('yyyy/MM/dd').format(toDo.dateTime)),
              titleTextStyle: const TextStyle(color: Colors.grey),
              subtitle: Text(toDo.text, style: const TextStyle(fontSize: 20.0)),
            ),
          )
          .toList(),
    );
  }
}
