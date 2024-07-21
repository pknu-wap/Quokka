import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text loginButtonText(String text)
{
  return Text(
    text,
    style: TextStyle(
      fontSize: 16.sp,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.001,
      color: Color(0xFFFFFFFF),
    ),
  );
}

Text loginSignUpText(String text){
  return Text(
    text,
    style: TextStyle(
      color: Color(0xFF3E3E3E),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700, //semi-bold가 없으므로, bold으로 대체
      fontSize: 14.sp,
      letterSpacing: 0.001,
    ),
  );
}