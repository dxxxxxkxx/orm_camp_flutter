import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'add_screen.dart';
import 'to_do.dart';
import 'to_do_list_tile.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late final Box<ToDo> _box;
  bool _isLoaded;

  _ListScreenState() : _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  @override
  void dispose() {
    _closeBox();
    super.dispose();
  }

  Future<void> _openBox() async {
    _box = await Hive.openBox('toDoList');

    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> _closeBox() async {
    await _box.close();

    setState(() {
      _isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddScreen(box: _box)),
              );

              setState(() {});
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _isLoaded
          ? ListView(
              children: _box.values
                  .map((final ToDo toDo) => ToDoListTile(
                        toDo: toDo,
                        check: (final ToDo todo) async {
                          toDo.isDone = !toDo.isDone;
                          await toDo.save();

                          setState(() {});
                        },
                        delete: (final ToDo toDo) async {
                          await toDo.delete();

                          setState(() {});
                        },
                      ))
                  .toList())
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
