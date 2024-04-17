
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'checkimage.dart';
import 'dart:convert';
class Upload_Image extends StatefulWidget {
  const Upload_Image({Key? key}) : super(key: key);

  @override
  _Upload_ImageState createState() => _Upload_ImageState();
}
class Student {
  String studentID;
  String major;
  String name;
  Student(this.studentID, this.major, this.name);
}

class _Upload_ImageState extends State<Upload_Image> {
  String parsedtext = ''; // 추출된 텍스트를 저장할 String 변수

  Student s1 = Student('','','');

  parsethetext() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {"base64Image": "data:image/png;base64,${img64.toString()}","language" :"kor"};
    var header = {"apikey" :"K88159020988957"};

    var post = await http.post(Uri.parse(url),body: payload,headers: header);
    var result = jsonDecode(post.body); // 추출 결과를 받아서 result에 저장
    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText']; // 추출결과를 다시 parsedtext로 저장
      extractInfoFromText();
    });
  }
  void extractInfoFromText() {
    int index = parsedtext.indexOf('남은시간');
    if (index != -1) {
      // "남은시간"을 기준으로 분할하여 앞 부분은 잘라냄
      String remainingText = parsedtext.substring(index);

      // "\n"을 기준으로 분할하여 리스트로 저장
      List<String> splitText = remainingText.split('\n');

      splitText.removeAt(0); // 첫 번째 요소인 "남은시간: 30"은 필요 없으므로 제거

      // 추출된 텍스트에서 학번, 이름, 전공 추출
      if (splitText.length >= 3) {
        setState(() {
          s1 = Student(splitText[2],splitText[0],splitText[1]); // s1에 객체 저장
        });
      }
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
                          parsethetext();
                          initState();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => Check_Image(Student: s1),
                            ),
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
                          Text(s1.name, style: const TextStyle(fontSize: 10)),
                          Text(s1.studentID, style: const TextStyle(fontSize: 10)),
                          Text(s1.major, style: const TextStyle(fontSize: 10)),
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