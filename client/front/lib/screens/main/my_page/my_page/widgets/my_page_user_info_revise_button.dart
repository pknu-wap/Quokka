import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ButtonStyle userInfoReviseButton(){
  return ButtonStyle(
// 버튼의 배경색 변경하기
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    minimumSize: MaterialStateProperty.all<Size>(Size(49.w, 21.h)),
// 버튼의 모양 변경하기
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Color(0xffA9A9A9), width: 0.5),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 5)),
  );
}