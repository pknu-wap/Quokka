import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/main/my_page/user_info/my_page_user_info.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';

import 'widgets/my_page_user_info_revise_button.dart';
import 'widgets/my_page_user_ranked_button.dart';

class MyPageUser extends StatefulWidget {
  @override
  _MyPageUserState createState() => _MyPageUserState();
}

class _MyPageUserState extends State<MyPageUser> {
  int _score = 600; // 평점

  @override
  Widget build(BuildContext context) {
    // 사용자 프로필
    return Container(
      child: Stack(
        children: [
          // 프로필 이미지
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Container(
              margin: EdgeInsets.only(top: 43.h, left: 24.w),
              child: InkWell(
                onTap: () {
                  print('Image button pressed');
                },
                child: SvgPicture.asset(
                  'assets/images/Avatar.svg',
                  width: 60.w,
                  height: 56.h,
                ),
              ),
            ),
          ),
          // 사용자 닉네임
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Container(
              margin: EdgeInsets.only(top: 54.h, left: 110.w),
              child: title('수현수현이'),
            ),
          ),
          // 회원 등급 페이지 이동 버튼
          UserRankedButton(
            score: _score,
            onTap: (){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => UserRanked()));
            },
          ),
          // 회원 정보 수정 텍스트
          Align(
            alignment: Alignment.centerRight, // 왼쪽 정렬
            child: Container(
              margin: EdgeInsets.only(top: 48.h, right: 26.w),
              child: greyText("회원 정보 수정", 8.sp),
            ),
          ),
          // 회원 정보 수정 버튼
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(top: 54.h, right: 24.w),
              child: ElevatedButton(
                onPressed: () {
                  print('회원 정보 수정 버튼 클릭');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPageUserInfo()));
                },
                style: userInfoReviseButton(),
                child: SvgPicture.asset(
                  "assets/images/user_info_revise.svg",
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}