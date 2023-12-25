import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'add_page.dart';
import 'to_do.dart';
import 'to_do_list_view.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final Box<ToDo> _box;
  bool _isLoaded;

  _ListPageState() : _isLoaded = false;

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
                MaterialPageRoute(builder: (_) => AddPage(box: _box)),
              );

              setState(() {});
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _isLoaded
          ? ToDoListView(box: _box)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
