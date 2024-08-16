import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordChangeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final TextInputType keyboardType;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final bool isEnabled; // Added this property
  final VoidCallback? onTap;

  const PasswordChangeTextField({
    Key? key,
    required this.controller,
    required this.text,
    required this.keyboardType,
    this.textColor = const Color(0xff404040),
    this.borderColor = const Color(0xffACACAC),
    this.fillColor = const Color(0xffF0F0F0),
    this.isEnabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 9.0.h),
      width: 320.w,
      height: 38.h,
      decoration: BoxDecoration(
        border: Border.all(color: isEnabled ? borderColor : Color(0xffACACAC), width: 0.5.w),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: isEnabled ? fillColor : Color(0xffF0F0F0), // Use fillColor and handle isEnabled
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.h, left: 11.48.w, right: 11.48.w),
        child: TextField(
          controller: controller,
          style: TextStyle(
            color: isEnabled ? textColor : Color(0xFFCC5C5C),
            fontSize: 13.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.01,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
          ),
          keyboardType: keyboardType,
          enabled: isEnabled, // Set enabled property
        ),
      ),
    );
  }
}
