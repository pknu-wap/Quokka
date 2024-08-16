import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/password_change_text_field.dart';

class PasswordChangeContainer extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final String grayText;
  final String errorText;
  final bool enabled;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final VoidCallback? onTap;

  const PasswordChangeContainer({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.grayText = "",
    this.errorText = "",
    this.enabled = true,
    this.textColor = const Color(0xff404040),
    this.borderColor = const Color(0xffACACAC),
    this.fillColor = const Color(0xffF0F0F0),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 항목 제목
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Text(
            labelText,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Color(0xff373737),
            ),
          ),
        ),
        // 회색 설명 텍스트
        if (grayText.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            grayText,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
              color: Color(0xff9E9E9E),
            ),
          ),
        ],
        // 텍스트 필드
        PasswordChangeTextField(
          controller: controller,
          text: "",
          keyboardType: keyboardType,
          textColor: textColor,
          borderColor: borderColor,
          fillColor: fillColor,
          isEnabled: enabled,
          onTap: onTap,
        ),
        // 경고 텍스트
        if (errorText.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            errorText,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
              color: Color(0xffE33939),
            ),
          ),
        ],
      ],
    );
  }
}
