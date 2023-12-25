import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'to_do.dart';

class ToDoListTile extends StatelessWidget {
  final ToDo toDo;
  final Future<void> Function(ToDo) check;
  final Future<void> Function(ToDo) delete;

  const ToDoListTile({
    super.key,
    required this.toDo,
    required this.check,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        check(toDo);
      },
      leading: toDo.isDone
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.check_circle_outline),
      title: Text(DateFormat('yyyy/MM/dd').format(toDo.dateTime)),
      titleTextStyle:
          TextStyle(color: toDo.isDone ? Colors.black : Colors.indigoAccent),
      subtitle: Text(
        toDo.text,
        style: TextStyle(
          color: toDo.isDone ? Colors.grey : Colors.black,
          fontSize: 20.0,
        ),
      ),
      trailing: IconButton(
          onPressed: () {
            delete(toDo);
          },
          icon: const Icon(Icons.delete)),
    );
  }
}
