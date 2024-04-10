import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'uploadimage.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 160)),
          Center(
            child: Image(
              image: AssetImage('assets/커카.png'), //커카 이미지 구현1
              width: 170.0,
            ),
          ),
          Form(
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.grey, //텍스트 박스 만들기
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.black, fontSize: 5.0))),
                        // 텍스트 박스 속 글자 색 블랙
                child: Container(
                    padding: EdgeInsets.all(40.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 320,
                            height: 50, // 텍스트 필드의 높이 설정
                            child: TextField(
                              decoration: InputDecoration(
                                /* labelText: '학번',*/
                                hintText: '학번',
                                filled: true,
                                fillColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none, // 테두리 없애기
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),  // 학번 텍스트 입력 구현(누르면 글자 사라짐)

                          SizedBox(height: 10), // 텍스트 필드 사이에 여백 추가하기

                          Container(
                            width: 320,
                            height: 50, // 텍스트 필드의 높이 설정
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '비밀번호',
                                filled: true,
                                fillColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors. black),
                                border: InputBorder.none, // 테두리 없애기
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true, // 비밀번호 안보이도록 하는 것
                            ),
                          ), // 비밀번호 텍스트 입력 구현(누르면 글자 사라짐 + 입력 시 비밀번호 숨기기)

                          SizedBox(height: 15), // 로그인 버튼 까지의 여백

                          // 다른 위젯들과 함께 Column에 로그인 버튼을 추가합니다.
                          ElevatedButton(
                            onPressed: () {
                              // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                              print('Login Button Clicked!');
                            },
                            style: ButtonStyle(
                              // 버튼의 배경색 변경하기
                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                              // 버튼의 크기 정하기
                              minimumSize: MaterialStateProperty.all<Size>(Size(319, 50)),
                              // 버튼의 모양 변경하기
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 원하는 모양에 따라 BorderRadius 조절
                              ),
                              ),
                              ),
                            child: Text(
                                '로그인',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
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
                              width: 320,
                              height: 52,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 220,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: Text(
                                        "비밀번호 찾기",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // 비밀번호 찾기 버튼 구현(누르면 찾기 화면으로 이동)

                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) => Upload_Image(),
                                  ),);
                              // Respond to button press
                              // 누르면 다음 페이지로 이동
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(100, 29)),
                              ),
                            child: Text(
                                "회원가입",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                          // 회원가입 버튼 구현(누르면 다음 페이지로 이동)


                          // 회원가입 "아직 회원이 아니신가요?" 텍스트 구현
                            Text(
                              "아직 회원이 아니신가요?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}