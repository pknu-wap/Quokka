import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  final ImageSource imageSource;

  const CameraView({Key? key, required this.imageSource}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // 이미지 선택하고 상태 업데이트
  Future<void> _getImage() async {
    try {
      final XFile? imageFile = await _picker.pickImage(
        source: widget.imageSource,
        maxHeight: 300,
        maxWidth: 300,
      );

      if (imageFile != null) {
        setState(() {
          _imageFile = imageFile;
        });
        Navigator.pop(context, _imageFile?.path);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _imageFile != null
            ? Image.file(File(_imageFile!.path))
            : const CircularProgressIndicator(),
      ),
    );
  }
}
