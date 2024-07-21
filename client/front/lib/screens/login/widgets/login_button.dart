import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ButtonStyle loginButton()
{
  return ButtonStyle(
// 버튼의 배경색 변경하기
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),
    minimumSize: MaterialStateProperty.all<Size>(Size(320.w, 50.h)),
// 버튼의 모양 변경하기
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // 원하는 모양에 따라 BorderRadius 조절
      ),
    ),
  );
}

ButtonStyle loginSignUpButton(){
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(100.w, 29.h)), // 버튼 크기
  );
}