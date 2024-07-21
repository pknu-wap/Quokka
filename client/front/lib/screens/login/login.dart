import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/login/widgets/login_button.dart';
import 'package:front/screens/login/widgets/login_button_text.dart';
import 'package:front/screens/login/widgets/login_text_field.dart';
import 'package:front/widgets/bar/navigation_bar.dart';
import '/screens/sign_up/sign_up.dart';
import '../main/errand_list/errand_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

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
        insertOverlay(context);
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
                decoration: loginBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.only(left: 17.w, right: 17.w),
                  child: loginTextField(maxStudentIdLength, _UsernameController, false, "학번"),
                ),
              ),

              // 비밀번호 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 6.0.h),
                width: 320.w,
                height: 50.h,
                decoration: loginBoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.only(left: 17.w, right: 17.w),
                  child: loginTextField(maxPasswordLength, _PasswordController, true, "비밀번호"),
                ),
              ),

              // 다른 위젯들과 함께 Column에 로그인 버튼을 추가합니다.
              Container(
                margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 15.0.h),
                child: ElevatedButton(
                  onPressed: () {
                    request(_UsernameController.text, _PasswordController.text);
                  },
                  style: ButtonStyle(),
                  child: Text("로그인"),
                ),
              ),
              // 로그인 버튼 구현(로그인 글자 + 버튼 누르면 메인화면으로 이동)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //이거 end로 이동
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 17.0.h),
                      child: Visibility(
                        visible: isVisible,
                        child: Text("잘못된 학번 또는 비밀번호입니다.",),
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
              // 비밀번호 찾기 버튼 구현(누르면 찾기 화면으로 이동)
              Container(
                margin: EdgeInsets.only(left: 0.w, right: 0.w, top: 24.h),
                child: TextButton(
                  onPressed: () {
                    // 누르면 다음 페이지로 이동
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  style: loginSignUpButton(),
                  child: loginSignUpText("회원가입"),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
