import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sign_up/sign_up.dart';
import 'errand_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import 'write_errand.dart';
void _insertOverlay(BuildContext context) {

  if (overlayEntry != null) return;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 0.h,
      left: 0.w,
      right: 0.w,
      child: Container(
        width: 360.w,
        height: 64.h,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          border: Border.all(
            color: Color(0xffCFCFCF),
            width: 0.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(185, 185, 185, 0.25),
              offset: Offset(5, -1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 22.w,
              height: 22.h,
              margin: EdgeInsets.only(left: 44.w,  top: 20.h, bottom: 17.32.h, ),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()));
                },
                icon: SvgPicture.asset(
                  'assets/images/home_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 19.31.w,
              height: 23.81.h,
              margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/images/profile_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 22.0.w,
              height: 22.h,
              margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => WriteErrand(),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/images/write_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 21.95.w,
              height: 24.21.h,
              margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,
                right: 43.92.w, ),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/images/history_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry!);
}
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
  final storage = FlutterSecureStorage();
  final int maxStudentIdLength = 9; // 학번 최대 길이 설정
  final int minPasswordLength = 8; // 비밀번호 최소 길이 설정
  final int maxPasswordLength = 20; // 비밀번호 최대 길이 설정
  bool isVisible = false;
  TextEditingController _UsernameController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();

  request(String username, String password) async {
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}login";
    String param = "?username=$username&password=$password";
    print(url + param);
    try {
      var post = await http.post(Uri.parse(url + param));
      if (post.statusCode == 200) {
        Map<String, dynamic> headers = post.headers;
        String? token = headers["authorization"];
        print("token: $token");
        await storage.write(key: 'TOKEN', value: token);
        //이제 앱 전역에서 토큰을 사용할 수 있음
        //지울 때는 이걸로 지워야함 await storage.delete(key: 'TOKEN); ex: 로그아웃
        setState(() {
          isVisible = false;
        });
        _insertOverlay(context);
        Navigator.push(
            //로그인 버튼 누르면 게시글 페이지로 이동하게 설정
            context,
            MaterialPageRoute(builder: (context) => Home()));
      } else
        {
          setState(() {
            isVisible = true;
          });
        }

    } catch(e) {
      print(e.toString());
    }
  }
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
      if (didPop) {
        return;
      }
      SystemNavigator.pop();
    },
    child : Scaffold(
      body: Container(
        // margin: EdgeInsets.only(top: 22.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 커카 이미지
              Container(
                margin: EdgeInsets.only(top: 103.h), // 커카 이미지에 대한 마진 설정
                width: 76.w,
                height: 105.h,
                child: Center(
                  child: SvgPicture.asset(
                  'assets/images/MainImage.svg',
                  ),
                ),
              ),
              // 학번 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 38.0.h),
                width: 320.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xFFE5E5E5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 17.w, right: 17.w),
                  child: TextField(
                    maxLength: maxStudentIdLength,
                    // 최대 길이 설정
                    controller: _UsernameController,
                    onChanged: (text) {
                      if (text.length > maxStudentIdLength) {
                        print('최대 $maxStudentIdLength자만 입력할 수 있습니다.');
                      }
                    },
                    style: TextStyle(
                        color: Color(0xFF404040),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: '학번',
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        color: Color(0xFF404040),
                      ),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),

              // 비밀번호 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 6.0.h),
                width: 320.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xFFE5E5E5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 17.w, right: 17.w),
                  child: TextField(
                    maxLength: maxPasswordLength,
                    controller: _PasswordController,
                    obscureText: true,
                    // 비밀번호 텍스트 필드의 최대 길이 설정
                    onChanged: (text) {
                      if (text.length < minPasswordLength) {
                        print('최소 $minPasswordLength자 이상 입력해주세요.');
                      } else if (text.length > maxPasswordLength) {
                        print('최대 $maxPasswordLength자만 입력할 수 있습니다.');
                      }
                    },
                    style: TextStyle(
                        color: Color(0xFF404040),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: '비밀번호',
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        color: Color(0xFF404040),
                      ),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),

              // 다른 위젯들과 함께 Column에 로그인 버튼을 추가합니다.
              Container(
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 15.0.h),
                child: ElevatedButton(
                  onPressed: () {
                    request(_UsernameController.text, _PasswordController.text);

                    // Navigator.push(
                    //   //로그인 버튼 누르면 게시글 페이지로 이동하게 설정
                    //     context,
                    //     MaterialPageRoute(builder: (context) => Main_post_page()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                    // 버튼의 크기 정하기
                    minimumSize: MaterialStateProperty.all<Size>(Size(319.w, 50.h)),
                    // 버튼의 모양 변경하기
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // 원하는 모양에 따라 BorderRadius 조절
                      ),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.001,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              // 로그인 버튼 구현(로그인 글자 + 버튼 누르면 메인화면으로 이동)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //이거 end로 이동
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 17.0.h),
                      //비밀번호 찾기 생기면 margin 11로
                      // margin: EdgeInsets.only(right: 11.0, top: 17.0), // 기존 마진
                      child: Visibility(
                        visible: isVisible,
                        child: Text(
                          "잘못된 학번 또는 비밀번호입니다.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFEC5147),
                          ),
                        ),
                      ),
                    ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           // 클릭 시 수행할 작업을 여기에 추가하세요
                    //           print("비밀번호 찾기 버튼이 클릭되었습니다.");
                    //           // 비밀번호 찾기 버튼 구현(누르면 찾기 화면으로 이동)
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.only(right: 14.0, top: 16.0),
                    //           width: 66,
                    //           height: 14,
                    //           child: Text(
                    //             "비밀번호 찾기",
                    //             style: TextStyle(
                    //               fontSize: 10,
                    //               fontFamily: 'Pretendard',
                    //               fontWeight: FontWeight.w400,
                    //               color: Color(0xFF555555),
                    //             ),
                    //           ),
                    //     ),
                    // ),
                  ],
                ),
              ),

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
                margin: EdgeInsets.only(left: 0.w, right: 0.w, top: 24.h),
                // width: 52,
                // height: 16,
                child: TextButton(
                  onPressed: () {
                    // 누르면 다음 페이지로 이동
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(100.w, 29.h)), // 버튼 크기
                  ),
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      color: Color(0xFF3E3E3E),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700, //semi-bold가 없으므로, bold으로 대체
                      fontSize: 14.sp,
                      letterSpacing: 0.001,
                    ),
                  ),
                ),
              ),
              // 회원가입 버튼 구현(누르면 다음 페이지로 이동)
            ],
          ),
        ),
      ),
    ),
    );
  }
}
