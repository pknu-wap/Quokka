import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class WhiteContainerUserImage extends StatelessWidget {
  final String selectedImage;

  WhiteContainerUserImage({required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.39.h),
      child: SvgPicture.asset(
        selectedImage,
        width: 86.w,
        height: 83.99.h,
      ),
    );
  }
}