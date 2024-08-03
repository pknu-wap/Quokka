import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  final ImageSource imageSource;

  const CameraWidget({Key? key, required this.imageSource}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

// 선택한 이미지 파일 보관
class _CameraWidgetState extends State<CameraWidget> {
  final ImagePicker picker = ImagePicker();
  XFile? _imageFile;

  Future<void> getImage() async {
    try {
      final XFile? imageFile = await picker.pickImage(
        source: widget.imageSource,
        maxHeight: 300,
        maxWidth: 300,
      );

      if (imageFile != null) {
        setState(() {
          _imageFile = imageFile;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getImage(); // 이미지 선택 시작 위해 호출
  }

  // 이미지 선택
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(File(_imageFile!.path))
                : const Text("Loading..."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _imageFile?.path);
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
