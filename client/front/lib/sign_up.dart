import 'dart:async'; //Timer이용 위함.
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'upload_image.dart'; // 파일 호출
import 'package:http/http.dart' as http;
import 'dart:convert';

//현재 화면에서 뒤로가기
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class Error{
  String code;
  var httpStatus;
  String message;
  Error(this.code,this.httpStatus,this.message);
  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
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

  int _seconds = 300; // 인증번호 시간 5분으로 초기화
  bool _isRunning = false;
  late Timer _timer;

  // _SignUpScreenState() : _timer = Timer(Duration(seconds: 0), () {});

  // 이메일 경고
  void emailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
          child: Container(
            // padding: EdgeInsets.all(20),
            width: 323,
            height: 214,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //배경색
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.04),
                child: Image.asset(
                  'assets/images/alert.png',
                  width: 76.83,
                  height: 76.83,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.08),
                  child: Text(
                    "이미 사용중인 이메일이에요!",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 0.00,
                      color: Color(0xff1A1A1A),
                    ),
                    textAlign: TextAlign.center, // 텍스트 중앙 정렬
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17.77),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(281.1, 47.25)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // 원하는 모양에 따라 BorderRadius 조절
                        ),
                      ),
                    ),
                    child: Text(
                      "확인",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 0.00,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
 // 인증 번호 경고
  void passwordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              // padding: EdgeInsets.all(20),
              width: 323,
              height: 214,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.04),
                    child: Image.asset(
                      'assets/images/alert.png',
                      width: 76.83,
                      height: 76.83,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.08),
                    child: Text(
                      "인증 번호가 일치하지 않아요!",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.00,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17.77),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1, 47.25)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // 원하는 모양에 따라 BorderRadius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.00,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 만료된 인증 번호 경고
  void expiredPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              // padding: EdgeInsets.all(20),
              width: 323,
              height: 214,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.04),
                    child: Image.asset(
                      'assets/images/alert.png',
                      width: 76.83,
                      height: 76.83,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.08),
                    child: Text(
                      "만료된 인증 번호에요!",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.00,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17.77),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1, 47.25)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // 원하는 모양에 따라 BorderRadius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.00,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }





  // 이메일 확인 API 연동
  emailRequest(String mail) async {
    print(mail);
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}mail";
    String param = "?mail=$mail";
    var response = await http.get(Uri.parse(url + param));
    if (response.statusCode == 200) {
        print(response.statusCode);
        requestMail = mail;
        setState(() {
          isVerificationCodeEnabled = true; // 이메일 인증번호 받기 버튼 클릭 시 비밀번호 텍스트 필드 활성화
          _resetTimer(); // 인증번호 타이머 초기화
          _startTimer(); // 인증번호 타이머 재시작
        });
    }
    else {
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "DUPLICATE_DATA")
      {
        emailDialog(context);
      }
      else if(error.code == "INVALID_FORMAT")
        {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("메일 주소 형식이 잘못됐습니다."),
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
      else
        {
          print(error.httpStatus+'\n');
          print(error.message+'\n');
          print(error.code+'\n');
        }
    }
  }


  // 인증번호 확인 API 연동
  codeRequest(String mail, String code) async {
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}mail/check";
    String param = "?mail=$mail&code=$code";
    var response = await http.get(Uri.parse(url + param));
    if (response.statusCode == 200) {
      checkVerificationCode(response.statusCode);
    }
    else {
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if (response.statusCode == 400) {
        print(error.httpStatus+'\n');
        print(error.message+'\n');
        print(error.code+'\n');
        passwordDialog(context);
      }
      else if (response.statusCode == 404) {
        print(error.httpStatus+'\n');
        print(error.message+'\n');
        print(error.code+'\n');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("해당 메일주소를 찾을 수 없습니다."),
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
      else if (response.statusCode == 408) {
        print(error.httpStatus+'\n');
        print(error.message+'\n');
        print(error.code+'\n');
        expiredPasswordDialog(context);
      }
      else {
        print(error.httpStatus+'\n');
        print(error.message+'\n');
        print(error.code+'\n');
      }
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

  // String errorMessage = ''; // 오류 메시지를 저장할 변수

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
                    // 이메일 주소 텍스트 필드
                    Container(
                      margin: EdgeInsets.only(top: 11.0),
                      width: 320,
                      height: 38,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Color(0xFFACACAC), width: 0.5  // 테두리 굵기
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Color(0xFFE5E5E5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2, left: 14, right: 14),
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(
                              color: Color(0xFF404040),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: '이메일 주소를 입력하세요 ex) pukyong.ac.kr',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                color: Color(0xff9E9E9E)),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    // 이메일 인증 번호 받기 버튼
                    Container(
                      margin: EdgeInsets.only(top: 19),
                      child: ElevatedButton(
                        onPressed: isEmailButtonEnabled
                            ? () {
                          emailRequest(emailController.text);
                          print('Email Button Clicked!');
                        } : null,
                        style: ButtonStyle(
                          // 버튼의 배경색 변경하기
                          backgroundColor: isEmailButtonEnabled
                              ? MaterialStateProperty.all<Color>(Color(0xFF7C3D1A))
                              : MaterialStateProperty.all<Color>(Color(0xFFBD9E8C)),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(320, 43)),
                          // 버튼의 모양 변경하기
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // 원하는 모양에 따라 BorderRadius 조절
                            ),
                          ),
                        ),
                        child: Text(
                          '이메일 인증 번호 받기',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 22.0, top: 18),
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
                        // 인증 번호 텍스트 필드
                        Container(
                          margin: EdgeInsets.only(top: 9.0),
                          width: 320,
                          height: 38,
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Color(0xFFACACAC), width: 0.5  // 테두리 굵기
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0xFFE5E5E5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 2, left: 14, right: 14),
                            child: TextField(
                              controller: verificationCodeController,
                              style: TextStyle(
                                  color: Color(0xFF404040),
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                hintText: "해당 메일로 전송된 인증 번호를 입력하세요",
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9E9E9E)
                                ),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              enabled: isVerificationCodeEnabled, // 인증 번호 텍스트 필드 활성화 여부 결정
                            ),
                          ),
                        ),
                        // 인증 번호 텍스트 입력 구현(누르면 글자 사라짐 + 입력 시 인증 번호 숨기기)

                        if (_isRunning)
                          Positioned(
                            top: 20,
                            right: 15,
                            child: Text(
                              '${_formatTime(_seconds)}',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7C3D1A)
                              ),
                            ),
                         ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 19),
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
                              MaterialStateProperty.all<Size>(Size(320, 43)),
                          // 버튼의 모양 변경하기
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // 원하는 모양에 따라 BorderRadius 조절
                            ),
                          ),
                        ),
                        child: Text(
                          '확인',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 22.0, top: 21.0),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       errorMessage,
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         fontFamily: 'Pretendard',
                    //         fontWeight: FontWeight.w400,
                    //         color: Color(0xffE33939),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
