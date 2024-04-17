import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sign_up.dart'; // 파일 호출

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final int maxStudentIdLength = 9; // 학번 최대 길이 설정
  final int minPasswordLength = 8; // 비밀번호 최소 길이 설정
  final int maxPasswordLength = 20; // 비밀번호 최대 길이 설정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.only(top: 22.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 122), // 커카 이미지에 대한 마진 설정
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/커카.png'),
                    width: 170.0,
                  ),
                ),
              ),
              Container(
                // 길이 제한 필요
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 43.0),
                // 학번 텍스트 필드에 대한 마진 설정
                width: 320,
                height: 50,
                child: TextField(
                  maxLength: maxStudentIdLength, // 최대 길이 설정
                  onChanged: (text) {
                    if (text.length > maxStudentIdLength) {
                      print('최대 $maxStudentIdLength자만 입력할 수 있습니다.');
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '학번',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF404040),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400),
                    contentPadding: EdgeInsets.only(left: 17, right: 17),
                    // 텍스트를 수직으로 가운데 정렬
                    filled: true,
                    fillColor: Color(0xFFE5E5E5),
                    labelStyle: TextStyle(color: Color(0xFFE5E5E5)),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    counterText: '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0),
                // 비밀번호 텍스트 필드에 대한 마진 설정
                width: 320,
                height: 50,
                child: TextField(
                  maxLength: maxPasswordLength,
                  // 비밀번호 텍스트 필드의 최대 길이 설정
                  onChanged: (text) {
                    if (text.length < minPasswordLength) {
                      print('최소 $minPasswordLength자 이상 입력해주세요.');
                    } else if (text.length > maxPasswordLength) {
                      print('최대 $maxPasswordLength자만 입력할 수 있습니다.');
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF404040),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400),
                    contentPadding: EdgeInsets.only(left: 17, right: 17),
                    // 텍스트를 수직으로 가운데 정렬
                    filled: true,
                    fillColor: Color(0xFFE5E5E5),
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    counterText: '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
              ),

              // 다른 위젯들과 함께 Column에 로그인 버튼을 추가합니다.
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 21.0, top: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                    print('Login Button Clicked!');
                  },
                  style: ButtonStyle(
                    // 버튼의 배경색 변경하기
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                    // 버튼의 크기 정하기
                    minimumSize: MaterialStateProperty.all<Size>(Size(319, 50)),
                    // 버튼의 모양 변경하기
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // 원하는 모양에 따라 BorderRadius 조절
                      ),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              // 로그인 버튼 구현(로그인 글자 + 버튼 누르면 메인화면으로 이동)

              GestureDetector(
                onTap: () {
                  // 클릭 시 수행할 작업을 여기에 추가하세요
                  print("비밀번호 찾기 버튼이 클릭되었습니다.");
                },
                child: Container(
                  margin: EdgeInsets.only(left: 273.0, top: 16.0),
                  width: 66,
                  height: 14,
                  child: Text(
                    "비밀번호 찾기",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ),
              // 비밀번호 찾기 버튼 구현(누르면 찾기 화면으로 이동)

              // GestureDetector(
              //   onTap: () {
              //     // 클릭 시 수행할 작업을 여기에 추가하세요
              //     print("회원가입 버튼이 클릭되었습니다.");
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(left: 155, right: 153, top: 24),
              //     width: 66,
              //     height: 14,
              //     child: Text(
              //       "회원가입",
              //       style: TextStyle(
              //         color: Color(0xFF3E3E3E),
              //         fontFamily: 'Roboto',
              //         fontWeight: FontWeight.w700,  //semi-bold가 없으므로, bold으로 대체
              //         fontSize: 14,
              //       ),
              //     ),
              //   ),
              // ),
              // 비밀번호 찾기 버튼 구현(누르면 찾기 화면으로 이동)
              Container(
                margin: EdgeInsets.only(left: 0, right: 0, top: 24), // 왜 안돼
                // width: 52,
                // height: 16,
                child: TextButton(
                  onPressed: () {
                    // Respond to button press
                    // 누르면 다음 페이지로 이동
                    print('Login Button Clicked!');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(100, 29)), // 버튼 크기
                  ),
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700, //semi-bold가 없으므로, bold으로 대체
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              // 회원가입 버튼 구현(누르면 다음 페이지로 이동)
            ],
          ),
        ),
      ),
    );
  }
}
