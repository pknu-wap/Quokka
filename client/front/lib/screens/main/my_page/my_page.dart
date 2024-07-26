import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
                      margin: EdgeInsets.only(top: 43.h, left: 24),
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


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}