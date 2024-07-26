import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedalTextBox extends StatelessWidget {
  final double width;
  final String colorText;
  final Color strokeColor;
  final Color fillColor;

  const MedalTextBox({
    Key? key,
    this.width = 27.0,
    this.colorText = "Bronze",
    this.strokeColor = const Color(0xFFAC6445),
    this.fillColor = const Color(0xFFF9B887),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: 12.h, // 박스 세로 길이 고정
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: strokeColor, width: 0.5.w),
        borderRadius: BorderRadius.circular(20), // 각도 고정
      ),
      child: Center(
        child: Text(
          colorText,
          style: TextStyle(
            color: strokeColor,
            fontSize: 8.sp,
            fontWeight: FontWeight.w400, // Regular
            fontFamily: "Pretendard",
            letterSpacing: 0.001,
          ),
        ),
      ),
    );
  }
}