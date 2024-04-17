import 'package:flutter/material.dart';
import 'profile.dart'; // 파일 호출

//현재 화면에서 뒤로가기
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController =
      TextEditingController(); // 이메일 입력란의 상태 관리
  TextEditingController verificationCodeController =
      TextEditingController(); // 인증 코드 입력란의 상태 관리
  bool isEmailButtonEnabled = false; // 이메일 전송 버튼의 활성화 상태 = 비활성화
  bool isVerifyButtonEnabled = false; // 인증 번호 버튼의 활성화 상태 = 비활성화

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 이메일 및 인증 코드 입력란의 상태 변화 감지
    super.initState();
    emailController.addListener(updateEmailButtonState);
    verificationCodeController.addListener(updateVerifyButtonState);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    emailController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  void updateEmailButtonState() {
    // 이메일 입력란의 텍스트 변경 감지하여 이메일 전성 버튼의 활성화 상태 업데이트
    setState(() {
      isEmailButtonEnabled = emailController.text.isNotEmpty;
    });
  }

  void updateVerifyButtonState() {
    // 인증 코드 입력란의 텍스트 변경 감지하여 이메일 전성 버튼의 활성화 상태 업데이트
    setState(() {
      isVerifyButtonEnabled = verificationCodeController.text.isNotEmpty;
    });
  }

/*class _SignUpScreenState extends State<SignUpScreen> {*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text(
              '회원가입',
              style: TextStyle(
                color: Color(0xFF111111),
                fontFamily: 'Paybooc',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Padding(padding: EdgeInsets.only(top: 50)),
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
                primaryColor: Color(0xFFE5E5E5), //텍스트 박스 만들기
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 13.0,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400),
                ),
              ),
              // 텍스트 박스 속 글자 색 블랙
              child: Container(
                // padding: EdgeInsets.all(40.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 22, top: 33.0),
                        // 비밀번호 텍스트 필드에 대한 마진 설정
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "이메일 주소",
                            style: TextStyle(
                              color: Color(0xFF373737),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 11.0),
                        // 비밀번호 텍스트 필드에 대한 마진 설정
                        width: 320,
                        height: 38,
                        // 텍스트 필드의 높이 설정
                        /*child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),*/
                        // 가로 패딩 추가
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            /* labelText: '학번',*/
                            hintText: '이메일 주소를 입력하세요 ex) pknu.ac.kr',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            filled: true,
                            fillColor: Color(0xFFE5E5E5),
                            labelStyle: TextStyle(
                                color: Color(0xFF404040),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            contentPadding:
                                EdgeInsets.only(left: 14, right: 14),
                            // 텍스트를 수직으로 가운데 정렬
                            border: InputBorder.none,
                            // 밑줄 없애기

                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)

                      Container(
                        margin: EdgeInsets.only(top: 0),
                        // 비밀번호 텍스트 필드에 대한 마진 설정
                        child: ElevatedButton(
                          onPressed: isEmailButtonEnabled
                              ? () {
                                  // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                  print('Email Button Clicked!');
                                }
                              : null,
                          style: ButtonStyle(
                            // 버튼의 배경색 변경하기
                            backgroundColor: isEmailButtonEnabled
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFF7C3D1A))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFBD9E8C)),
                            /*backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),*/
                            // 0xFF로 시작하는 16진수 색상 코드 사용,
                            // 버튼의 크기 정하기
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(320, 40)),
                            // 버튼의 모양 변경하기
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // 원하는 모양에 따라 BorderRadius 조절
                              ),
                            ),
                          ),
                          child: Text(
                            '이메일 인증 번호 받기',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 22.0, top: 21.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "인증 번호",
                            style: TextStyle(
                              color: Color(0xFF373737),
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 9.0),
                        width: 320,
                        height: 38, // 텍스트 필드의 높이 설정
                        child: TextField(
                          controller: verificationCodeController,
                          decoration: InputDecoration(
                            hintText: "해당 메일로 전송된 인증 번호를 입력하세요",
                            hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            filled: true,
                            fillColor: Color(0xFFE5E5E5),
                            labelStyle: TextStyle(
                                color: Color(0xFF404040),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            contentPadding:
                                EdgeInsets.only(left: 11, right: 11),
                            // 텍스트를 수직으로 가운데 정렬
                            border: InputBorder.none,
                            // 밑줄 없애기

                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true, // 비밀번호 안보이도록 하는 것
                        ),
                      ), // 비밀번호 텍스트 입력 구현(누르면 글자 사라짐 + 입력 시 비밀번호 숨기기)

                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: ElevatedButton(
                          onPressed: isVerifyButtonEnabled
                              ? () {
                                  // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                  print('Verify Button Clicked!');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreen()));
                                  style:
                                  ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        Size(100, 29)),
                                  );
                                }
                              : null,
                          style: ButtonStyle(
                            // 버튼의 배경색 변경하기
                            backgroundColor: isVerifyButtonEnabled
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFF7C3D1A))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFBD9E8C)),
                            /*backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),*/
                            // 0xFF로 시작하는 16진수 색상 코드 사용,
                            // 버튼의 크기 정하기
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(320, 40)),
                            // 버튼의 모양 변경하기
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // 원하는 모양에 따라 BorderRadius 조절
                              ),
                            ),
                          ),
                          child: Text(
                            '확인',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
// 로그인 버튼 까지의 여백
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
