import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'checkimage.dart';

class Upload_Image extends StatefulWidget {
  const Upload_Image({Key? key}) : super(key: key);

  @override
  _Upload_ImageState createState() => _Upload_ImageState();
}

class _Upload_ImageState extends State<Upload_Image> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future<void> getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: SizedBox(
              height: 25.0,
              child: const Text(
                '본인인증',
                style: TextStyle(
                  fontFamily: 'paybooc',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.01,
                  color: Color(0xff111111),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 22.0, top: 30.0),
                child: const Text(
                  '모바일 학생증 인증',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.01,
                    color: Color(0xff373737),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Stack(
                  children: <Widget>[
                    Image.asset('assets/Rectangle 1.png', width: 320, height: 202, fit: BoxFit.cover),
                    Positioned(
                      left: 0, right: 0, top: 0, bottom: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 100,
                          color: Color(0xff8D8D8D),
                        ),
                        onPressed: () {
                          // 이 버튼을 누르면 갤러리가 열리고 이미지를 가져오도록 설정
                          getImage(ImageSource.gallery);
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => Check_Image()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 22.0, top: 36.0),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 9.0),
                            child: const Text(
                              '업로드 파일 예시',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.01,
                                color: Color(0xff373737),
                              ),
                            ),
                          ),
                          const Text(
                            '파일 형식  jpg / png',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 12,
                              letterSpacing: 0.01,
                              color: Color(0xff373737),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 139.58,
                      height: 256.44,
                      margin: const EdgeInsets.only(left: 22.0, top: 18.0),
                      child: Image.asset('assets/upload_image_sample.png'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}