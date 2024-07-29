import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/login.dart';

final storage = FlutterSecureStorage();
OverlayEntry? overlayEntry;

class ShowLogoutDialog extends StatelessWidget{
  ShowLogoutDialog({
    Key? key,
  }):super(key:key);

  // 로그아웃
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Color(0xffB6B6B6), width: 1.w),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 323.w,
          height: 214.h,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //배경색
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.h, ),
                child:  Icon(
                  Icons.logout,
                  color: Color(0xffA98474),
                  size: 40.sp,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.h, ),
                child: Text(
                  "로그아웃 하시겠어요?",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.04,
                    color: Color(0xff1A1A1A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16.w, ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(134.18.w, 45.h)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          "로그아웃",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            letterSpacing: 0.00,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                          await storage.delete(key: 'TOKEN');
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.w, ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffFFFFFF)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(134.18.w, 45.h)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: Color(0xff999999), // 테두리 색상
                                  width: 1.w // 테두리 두께
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          "취소",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            letterSpacing: 0.00,
                            color: Color(0xff3E3E3E),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context, String alertMessage) {
  showDialog(
    context: context,
    builder: (context) {
      return ShowLogoutDialog();
    },
  );
}