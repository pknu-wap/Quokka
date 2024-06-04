import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'upload_image.dart';
import 'profile.dart';
class Check_Image extends StatefulWidget {
  final User u1;

  Check_Image({
    Key? key,
    required this.u1,
  }) : super(key: key);

  @override
  Check_ImageState createState() => Check_ImageState();
}

class Check_ImageState extends State<Check_Image> {
  final int IDLength = 9;
  late User u1;
  late TextEditingController _MajorController;
  late TextEditingController _IDController;
  late TextEditingController _NameController;
  late bool isIDValid = u1.id.length == IDLength;
  // late bool isMajorValid;
  // late bool isNameValid;

  //학번 중복 검사 API
  request(String ID) async {
    print(ID);
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}join";
    String param = "/$ID/idExists";
    print(url + param);

    try {
      var response = await http.get(Uri.parse(url + param));
      if (response.statusCode == 200) {
        Navigator.push(
            //로그인 버튼 누르면 게시글 페이지로 이동하게 설정
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(u1: u1)));
      } else {
        String jsonString = response.body;
        Map<String, dynamic> error = jsonDecode(jsonString);
        print("code : " + error['code'].toString() + "\n");
        print("httpStatusCode : " + error['httpStatusCode'].toString() + "\n");
        print("message : " + error['message'].toString() + "\n");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("이미 가입된 학번입니다."),
              actions: <Widget>[
                TextButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    u1 = widget.u1;
    u1.id = u1.id.trim();
    _MajorController = TextEditingController(text: u1.department.trim());
    _IDController = TextEditingController(text: u1.id.trim());
    _NameController = TextEditingController(text: u1.name.trim());

    // 학부/학과
    _MajorController.addListener(
          () {
        setState(() {
          isIDValid = _IDController.text.length == IDLength &&
              int.tryParse(_IDController.text) != null;
          if (isIDValid)
            u1 = User(u1.mail, _MajorController.text, _NameController.text,
                _IDController.text, '', '');
        });
      },
    );

    // 학번
    _IDController.addListener(
          () {
        setState(() {
          isIDValid = _IDController.text.length == IDLength &&
              int.tryParse(_IDController.text) != null;
          if (isIDValid)
            u1 = User(u1.mail, _MajorController.text, _NameController.text,
                _IDController.text, '', '');
        });
      },
    );

    // 이름
    _NameController.addListener(
      () {
        setState(() {
          isIDValid = _IDController.text.length == IDLength &&
              int.tryParse(_IDController.text) != null;
          if (isIDValid)
            u1 = User(u1.mail, _MajorController.text, _NameController.text,
                _IDController.text, '', '');
        });
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              leading: Padding(
                padding: EdgeInsets.only(top: 26.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              title: Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: SizedBox(
                    height: 25.0,
                    child: Text('회원가입',
                        style: TextStyle(
                          fontFamily: 'paybooc',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          letterSpacing: 0.01,
                          color: Color(0xff111111),
                        )),
                  ))),
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 24.0, top: 30.0),
                  child: Text('학부 / 학과',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.01,
                        color: Color(0xff373737),
                      ))),
              // 학부/학과 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                width: 320,
                height: 38,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xFFACACAC),
                      width: 0.5 // 테두리 굵기
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xffF0F0F0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11,left: 14, right: 14),
                  child: TextField(
                    controller: _MajorController,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.01,
                      color: Color(0xff404040),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 13),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                ),

              // 학번 텍스트
              Container(
                  margin: EdgeInsets.only(left: 22.0, top: 28.0),
                  child: Text('학번',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.01,
                        color: Color(0xff373737),
                      ))),

              // 학번 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                width: 320,
                height: 38,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xffACACAC),
                      width: 0.5 // 테두리 굵기
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xffF0F0F0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11,left: 14, right: 14),
                  child: TextField(
                    maxLength: IDLength,
                    controller: _IDController,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.01,
                      color: Color(0xff404040),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 13),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                )
              ),

              // 이름 텍스트
              Container(
                  margin: EdgeInsets.only(left: 22.0, top: 28.0),
                  child: Text('이름',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.01,
                        color: Color(0xff373737),
                      ))),
              // 이름 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                width: 320,
                height: 38,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xffACACAC),
                      width: 0.5 // 테두리 굵기
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xffF0F0F0),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 11, bottom: 11,left: 14, right: 14),
                    child: TextField(
                      controller: _NameController,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Pretendard',
                        letterSpacing: 0.01,
                        color: Color(0xff404040),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 13),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                    )
                )
              ),
              //설명
              Container(
                  margin: EdgeInsets.only(left: 20.9, top: 29.0),
                  child: Text('해당 정보가 일치하다면 확인 버튼을 눌러주세요.',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        letterSpacing: 0.01,
                        color: Color(0xff343434),
                      ))),

              //확인 버튼
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                width: 320,
                height: 43,
                decoration: BoxDecoration(
                  color: (isIDValid) && (_MajorController.text.isNotEmpty) && (_NameController.text.isNotEmpty)
                      ? Color(0xff7C3D1A) : Color(0xffBD9E8C),
                  // border: Border.all(
                  //   width: 0.5,
                  //   color: Color(0xffACACAC),
                  // ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: (isIDValid) && (_MajorController.text.isNotEmpty) && (_NameController.text.isNotEmpty)
                        ? () {
                            //학번이 타당하면 request실행, u1데이터는 담겨있음
                            request(_IDController.text);
                          }
                        : null,
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        letterSpacing: 0.01,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20.0, top: 9.0),
                  child: Text('* 해당 정보가 일치하지 않으면 알맞게 바꿔주세요.',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: 0.01,
                        color: Color(0xffFF4B4B),
                      ))),
            ],
          ))),
    );
  }
}
