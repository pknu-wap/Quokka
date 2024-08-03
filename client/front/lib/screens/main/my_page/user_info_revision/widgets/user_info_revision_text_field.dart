import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RevisionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final TextInputType keyboardType;
  final bool obscureText;

  const RevisionTextField({
    Key? key,
    required this.controller,
    required this.text,
    required this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 9.0.h),
      width: 320.w,
      height: 38.h,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffACACAC), width: 0.5.w),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xffF0F0F0),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h, left: 11.48.w, right: 11.48.w),
        child: TextField(
          controller: controller,
          obscureText: obscureText, // 텍스트 가리기
          style: TextStyle(
              color: Color(0xFF404040),
              fontSize: 13.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.01),
          decoration: InputDecoration(
            border: InputBorder.none, // 밑줄 제거
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
