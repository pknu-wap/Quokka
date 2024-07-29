import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "회원 정보",
        style: TextStyle(
            color: Color(0xFF111111),
            fontFamily: 'Paybooc',
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            letterSpacing: 0.01
        ),
        textAlign: TextAlign.center,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff6B6B6B),
          size: 24.0,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
          onPressed: (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyPageUserInfoRevision()));
          },
          child: Text(
            '수정',
            style: TextStyle(
              color: Color(0xff6B6B6B),
              fontFamily: 'Paybooc',
              fontWeight: FontWeight.w700, //semibold
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
      centerTitle: true, // 타이틀 중앙 정렬
      backgroundColor: Colors.white, // 앱바, 상단 네비게이션 바 배경색 변경
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}