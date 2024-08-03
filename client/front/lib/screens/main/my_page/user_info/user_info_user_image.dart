import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImage extends StatelessWidget {
  final String imagePath;
  final bool isSvg;
  final VoidCallback onTap;

  const UserImage({
    Key? key,
    required this.imagePath,
    required this.isSvg,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: isSvg ?
              SvgPicture.asset(
                imagePath,
                width: 95.w,
                height: 90.h,
              ) : ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: Image.file(
                  File(imagePath),
                  width: 95.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 프로필 이미지 카메라 아이콘
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 55.h, right: 10.w),
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