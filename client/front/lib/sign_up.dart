import 'package:flutter/material.dart';

//현재 화면에서 뒤로가기
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  bool isEmailButtonEnabled = false;
  bool isVerifyButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateEmailButtonState);
    verificationCodeController.addListener(updateVerifyButtonState);
  }

  @override
  void dispose() {
    emailController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  void updateEmailButtonState() {
    setState(() {
      isEmailButtonEnabled = emailController.text.isNotEmpty;
    });
  }

  void updateVerifyButtonState() {
    setState(() {
      isVerifyButtonEnabled = verificationCodeController.text.isNotEmpty;
    });
  }


/*class _SignUpScreenState extends State<SignUpScreen> {*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '회원가입',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        leading: IconButton(
          icon: Image.asset('assets/Vector 9.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          /*Center(
            child: Text(
              "회원가입",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),*/
          Form(
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.grey, //텍스트 박스 만들기
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.black, fontSize: 5.0),
                    ),
                ),
                // 텍스트 박스 속 글자 색 블랙
                child: Container(
                    padding: EdgeInsets.all(40.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "이메일 주소",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          SizedBox(height: 8), // 텍스트 필드 사이에 여백 추가하기

                          Container(
                            width: double.infinity,
                            height: 38, // 텍스트 필드의 높이 설정
                            /*child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),*/ // 가로 패딩 추가
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                /* labelText: '학번',*/
                                hintText: '이메일 주소를 입력하세요 ex) pknu.ac.kr',
                                hintStyle: TextStyle(fontSize: 10),
                                filled: true,
                                fillColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.black),
/*                                border: InputBorder.none, // 테두리 없애기*/

                       /*         suffixStyle: TextStyle(fontSize: 16),*/
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),  // 이메일 텍스트 입력 구현(누르면 글자 사라짐)

                          SizedBox(height: 12), // 텍스트 필드 사이에 여백 추가하기

                          ElevatedButton(
                            onPressed: isEmailButtonEnabled ? () {
                              // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                              print('Email Button Clicked!');
                            }: null,
                            style: ButtonStyle(
                              // 버튼의 배경색 변경하기
                              backgroundColor: isEmailButtonEnabled ? MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)) : MaterialStateProperty.all<Color>(Color(0xFFBD9E8C)),
                              /*backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),*/ // 0xFF로 시작하는 16진수 색상 코드 사용,
                              // 버튼의 크기 정하기
                              minimumSize: MaterialStateProperty.all<Size>(Size(320, 40)),
                              // 버튼의 모양 변경하기
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // 원하는 모양에 따라 BorderRadius 조절
                                ),
                              ),
                            ),
                            child: Text(
                              '이메일 인증 번호 받기',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 14), // 텍스트 필드 사이에 여백 추가하기

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "인증 번호",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          SizedBox(height: 8), // 텍스트 필드 사이에 여백 추가하기


                          Container(
                            width: 320,
                            height: 38, // 텍스트 필드의 높이 설정
                            child: TextField(
                              controller: verificationCodeController,
                              decoration: InputDecoration(
                                hintText: "해당 메일로 전송된 인증 번호를 입력하세요",
                                hintStyle: TextStyle(fontSize: 10),
                                filled: true,
                                fillColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors. black),
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
                              obscureText: true, // 비밀번호 안보이도록 하는 것
                            ),
                          ), // 비밀번호 텍스트 입력 구현(누르면 글자 사라짐 + 입력 시 비밀번호 숨기기)

                          SizedBox(height: 12), // 텍스트 필드 사이에 여백 추가하기

                          ElevatedButton(
                            onPressed: isVerifyButtonEnabled ? () {
                              // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                              print('Verify Button Clicked!');
                            }: null,
                            style: ButtonStyle(
                              // 버튼의 배경색 변경하기
                              backgroundColor: isVerifyButtonEnabled ? MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)) : MaterialStateProperty.all<Color>(Color(0xFFBD9E8C)),
                              /*backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),*/ // 0xFF로 시작하는 16진수 색상 코드 사용,
                              // 버튼의 크기 정하기
                              minimumSize: MaterialStateProperty.all<Size>(Size(320, 40)),
                              // 버튼의 모양 변경하기
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // 원하는 모양에 따라 BorderRadius 조절
                                ),
                              ),
                            ),
                            child: Text(
                              '확인',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 15), // 로그인 버튼 까지의 여백
                        ],
                      ),
                    ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}