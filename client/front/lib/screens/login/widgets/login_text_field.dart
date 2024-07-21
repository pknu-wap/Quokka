import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration loginBoxDecoration()
{
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    color: Color(0xFFE5E5E5),
  );
}

TextField loginTextField(int loginMaxLength, TextEditingController loginController, bool loginObscureText, String loginHintText){
  return TextField(
    maxLength: loginMaxLength, // 최대 길이 설정
    controller: loginController,
    obscureText: loginObscureText,
    style: TextStyle(
        color: Color(0xFF404040),
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w400),
    decoration: InputDecoration(
      hintText: loginHintText,
      hintStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: Color(0xFF404040),
      ),
      border: InputBorder.none,
      counterText: '',
    ),
    keyboardType: TextInputType.number,
  );
}