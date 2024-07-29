import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("프로필 이미지 변경 클릭!");
      },
      child: Container(
        margin: EdgeInsets.only(top: 90.h),
        width: 115.w,
        height: 107.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            // 프로필 이미지
            Align(
              alignment: Alignment.center,
              child: Container(
                child: SvgPicture.asset(
                  'assets/images/Avatar.svg',
                  width: 95.w,
                  height: 90.h,
                ),
              ),
            ),
            // 카메라 이미지 버튼
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 55.h, right: 10.w), // Adjust margins
                child: SvgPicture.asset(
                  'assets/images/camera.svg',
                  width: 21.w,
                  height: 17.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}