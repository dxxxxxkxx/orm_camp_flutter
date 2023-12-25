import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final ImagePicker _picker;
  final PageController _controller;
  List<XFile>? _imageFileList;
  int _currentPage;

  _GridScreenState()
      : _picker = ImagePicker(),
        _controller = PageController(),
        _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _getImageFileList();
  }

  Future<void> _getImageFileList() async {
    _imageFileList = await _picker.pickMultiImage();

    if (_imageFileList != null) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        if (++_currentPage > _imageFileList!.length - 1) {
          _currentPage = 0;
        }

        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('전자 갤러리')),
      body: _imageFileList != null
          ? PageView(
              controller: _controller,
              children: _imageFileList!.map((final XFile imageFile) {
                return FutureBuilder<Uint8List>(
                    future: imageFile.readAsBytes(),
                    builder: (
                      final BuildContext context,
                      final AsyncSnapshot<Uint8List> snapshot,
                    ) {
                      if (snapshot.data != null &&
                          snapshot.connectionState != ConnectionState.waiting) {
                        return Image.memory(
                          snapshot.data!,
                          width: double.infinity,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              }).toList(),
            )
          : const Center(child: Text('No image file')),
    );
  }
}
