import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/main/my_page/my_page/utils/get_medal_image_util.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';

import 'utils/change_color_util.dart';
import 'utils/get_medal_box_util.dart';
import 'widgets/my_page_medal_box.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _score = 600; // 평점

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCenter(
        title: '마이페이지',
        onBackPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          children: [
            // 사용자 프로필
            Container(
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
                  // 등급(점수에 따라 다른 등급 배지와 텍스트)
                  Align(
                    alignment: Alignment.centerLeft, // 왼쪽 정렬
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => UserRanked()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 78.h, left: 107.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 배지
                            SvgPicture.asset(
                              getMedalImage(_score),
                              width: getMedalImageSize(_score).w,
                              height: getMedalImageSize(_score).h,
                            ),
                            SizedBox(width: 2.w),
                            // 등급 텍스트 박스
                            MedalTextBox(
                              width: getMedalBoxWidth(_score).w,
                              colorText: changeColor(_score),
                              strokeColor: getMedalBoxStrokeColor(_score),
                              fillColor: getMedalBoxFillColor(_score),
                            ),
                            SizedBox(width: 5.w),
                            // 회원 등급 페이지 이동 버튼
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffD9D9DE),
                              size: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}