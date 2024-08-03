import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhiteContainerUserImage extends StatelessWidget {
  final String selectedImagePath;
  final bool isSvg;

  const WhiteContainerUserImage({
    Key? key,
    required this.selectedImagePath,
    this.isSvg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.39.h),
      child: isSvg
          ? SvgPicture.asset( // 커카 이미지
        selectedImagePath,
        width: 86.w,
        height: 83.99.h,
      )
          : Image.file( // 카메라, 갤러리에서 선택한 이미지
        File(selectedImagePath),
        width: 86.w,
        height: 83.99.h,
        fit: BoxFit.cover,
      ),
    );
  }
}