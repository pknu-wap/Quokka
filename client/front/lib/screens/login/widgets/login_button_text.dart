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