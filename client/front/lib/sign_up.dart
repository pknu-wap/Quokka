import 'dart:async'; //Timer이용 위함.
import 'package:flutter/material.dart';
import 'upload_image.dart'; // 파일 호출
import 'package:http/http.dart' as http;


//현재 화면에서 뒤로가기
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _SignUpScreenState extends State<SignUpScreen> {
  final int minverificationLength = 6; // 닉네임 최소 길이 설정
  final int maxverificationLength = 6; // 닉네임 최대 길이 설정

  TextEditingController emailController = TextEditingController(); // 이메일 입력란의 상태 관리
  TextEditingController verificationCodeController = TextEditingController(); // 인증 코드 입력란의 상태 관리

  bool isEmailButtonEnabled = false; // 이메일 전송 버튼의 활성화 상태 = 비활성화
  bool isVerificationCodeEnabled = false; // 인증 번호 텍스트 필드의 활성화 상태 = 비활성화
  bool isVerifyButtonEnabled = false; // 인증 번호 확인 버튼의 활성화 상태 = 비활성화

  String requestMail = "";

  int _seconds = 300;  // 인증번호 시간 5분으로 초기화
  bool _isRunning = false;
  late Timer _timer;
  // _SignUpScreenState() : _timer = Timer(Duration(seconds: 0), () {});

  // 이메일 확인 API 연동
  emailRequest(String mail) async {
    print('ok' + mail);
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/mail";
    String param = "?mail=$mail";
    try {
      var response = await http.get(Uri.parse(url + param));
      if (response.statusCode == 200) {
        print('200 ok');
        requestMail = mail;
        setState(() {
          isVerificationCodeEnabled = true; // 이메일 인증번호 받기 버튼 클릭 시 비밀번호 텍스트 필드 활성화
          _resetTimer(); // 인증번호 타이머 초기화
          _startTimer(); // 인증번호 타이머 재시작
        });
      }
      else if (response.statusCode == 400) {
        print('400');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("이미 사용중인 이메일입니다."),
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
      else {
        print('이메일 error 발생');
      }
    } catch(e) {
      print(e.toString());
    }
  }

  // 인증번호 확인 API 연동
  codeRequest(String mail, String code) async {
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/mail/check";
    String param = "?mail=$mail&code=$code";
    try{
      var response = await http.get(Uri.parse(url + param));

      if (response.statusCode == 200) {
        checkVerificationCode(response.statusCode);
      } else if (response.statusCode == 404){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("해당 메일주소를 찾을 수 없습니다."), //먼가 이상함 -> 필요한가?
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
      } else if (response.statusCode == 408) { // 인증번호를 받은 후, 타이머가 끝났는데 새로 받은 인증번호가 없을 때,
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("만료된 인증번호입니다."),
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
      } else if (response.statusCode == 400){ // 인증번호를 받은 후, 타이머가 끝나지 않았는데, 가장 최근 보낸 인증번호가 아닐 때,
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("인증번호가 틀립니다."),
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
      } else {
        print('인증번호 error 발생');
      }
    } catch(e) {
      print(e.toString());
    }
  }


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
    _timer.cancel(); // 타이머 계속 실행 중인 경우 dispose 시에 취소해야 함.
    super.dispose();
  }
  void _resetTimer(){ // 타이머가 화면에 반영되도록 함
    setState(() {
      _seconds = 300; //5분
    });
  }
  void _startTimer() { // 타이머 실행
    _isRunning = true; // false상태였는데, true가 되면, 타이머 실행
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {// 5분을 받아서 1초마다 반복되는 타이머 생성
      setState(() {
        if (_seconds > 0) {
          _seconds --; // 시간이 갈 수록 1씩 감소하기
        } else {
          _resetTimer(); // 시간이 다 지나가면 타이머를 리셋하기
          _isRunning = false;
        }
      });
    });
  }

  // 화면에 보이는 타이머 형태
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // 정규 표현식을 사용 -> 이메일 주소 유효성 검사
  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9+-\_.]+@pukyong\.ac\.kr$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

// 이메일 인증 번호 받기 버튼 상태 업데이트
  void updateEmailButtonState() {
    String enteredEmail = emailController.text.trim(); // 사용자가 입력한 이메일

    if (isValidEmail(enteredEmail)) {
      // 이메일이 @pukyong.ac.kr 형식을 지켰는가
      setState(() {
        isEmailButtonEnabled = true; // 이메일 인증 번호 받기 버튼을 활성화
      });
    } else {
      // 그 외의 경우 버튼 비활성화
      setState(() {
        isEmailButtonEnabled = false;
      });
    }
  }
// 인증 번호 확인 버튼 상태 업데이트
  void updateVerifyButtonState() {
    setState(() {
      if (isEmailButtonEnabled) {
        isVerificationCodeEnabled = true; // 인증번호 텍스트 필드 활성화
        isVerifyButtonEnabled = true; // 인증번호 확인 버튼 활성화
      }
    });
  }

  String errorMessage = ''; // 오류 메시지를 저장할 변수

  // 실제로 전송된 인증번호와 사용자가 입력한 인증번호가 같은지 확인
  void checkVerificationCode(int statusCode) {
    // 사용자가 입력한 인증 번호가 실제로 전송된 인증 번호와 일치할 때,
    print(statusCode);
    if (statusCode == 200) {
      // 다음 화면으로 이동하면서 email주소를 넘김
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Upload_Image(requestMail: requestMail)));
    } else if(statusCode == 400){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("인증 번호"),
            content: Text("인증 번호가 일치하지 않습니다."),
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
    else if(statusCode == 408) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("만료된 인증번호입니다."),
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
  }

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
          Form(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 22, top: 33.0),
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
                      width: 320,
                      height: 38,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: '이메일 주소를 입력하세요 ex) pukyong.ac.kr',
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
                          contentPadding: EdgeInsets.only(left: 14, right: 14),
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
                      margin: EdgeInsets.only(top: 19),
                      child: ElevatedButton(
                        onPressed: isEmailButtonEnabled
                            ? () {
                          emailRequest(emailController.text);
                                // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                // startTimer();
                                print('Email Button Clicked!');
                              }
                            : null,
                        style: ButtonStyle(
                          // 버튼의 배경색 변경하기
                          backgroundColor: isEmailButtonEnabled
                              ? MaterialStateProperty.all<Color>(Color(0xFF7C3D1A))
                              : MaterialStateProperty.all<Color>(Color(0xFFBD9E8C)),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(320, 40)),
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
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF373737),
                          ),
                        ),
                      ),
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
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
                                  fontWeight: FontWeight.w400
                              ),
                              filled: true,
                              fillColor: Color(0xFFE5E5E5),
                              labelStyle: TextStyle(
                                  color: Color(0xFF404040),
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400),
                              contentPadding: EdgeInsets.only(left: 11, right: 11),
                              // 텍스트를 수직으로 가운데 정렬
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                ),
                              ),                              // 밑줄 없애기
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
                            // obscureText: true, // 인증 번호 안보이도록 하는 것
                            enabled: isVerificationCodeEnabled, // 인증 번호 텍스트 필드 활성화 여부 결정
                          ),
                        ), // 인증 번호 텍스트 입력 구현(누르면 글자 사라짐 + 입력 시 인증 번호 숨기기)

                        if (_isRunning)
                          Positioned(
                            top: 20,
                            right: 10,
                            child: Text(
                              '${_formatTime(_seconds)}',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFD4848)
                              ),
                            ),
                         ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 21),
                      child: ElevatedButton(
                        onPressed: isVerifyButtonEnabled
                            ? () {
                                print('Verify Button Clicked!');
                                String enteredCode = verificationCodeController.text.trim(); // 사용자가 입력한 인증번호
                                codeRequest(requestMail, enteredCode);
                              }
                            : null,
                        style: ButtonStyle(
                          // 버튼의 배경색 변경하기
                          backgroundColor: isVerifyButtonEnabled
                              ? MaterialStateProperty.all<Color>(
                                  Color(0xFF7C3D1A))
                              : MaterialStateProperty.all<Color>(
                                  Color(0xFFBD9E8C)),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(320, 40)),
                          // 버튼의 모양 변경하기
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    Container(
                      margin: EdgeInsets.only(left: 22.0, top: 21.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            color: Color(0xE33939),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
