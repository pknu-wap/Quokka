import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screens/main/my_page/my_page/utils/change_color_util.dart';
import 'package:front/screens/main/my_page/my_page/utils/get_medal_box_util.dart';

import '../utils/get_medal_image_util.dart';
import 'my_page_medal_box.dart';

class UserRankedButton extends StatelessWidget {
  final int score;
  final VoidCallback onTap;

  UserRankedButton({
    required this.score,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // 왼쪽 정렬
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(top: 78.h, left: 107.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 배지
              SvgPicture.asset(
                getMedalImage(score),
                width: getMedalImageSize(score).w,
                height: getMedalImageSize(score).h,
              ),
              SizedBox(width: 2.w),
              // 등급 텍스트 박스
              MedalTextBox(
                width: getMedalBoxWidth(score).w,
                colorText: changeColor(score),
                strokeColor: getMedalBoxStrokeColor(score),
                fillColor: getMedalBoxFillColor(score),
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
    );
  }
}