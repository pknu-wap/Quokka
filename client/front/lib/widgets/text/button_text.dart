import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text buttonText(String text)
{
  return Text(
    text,
    style: TextStyle(
      fontSize: 15.sp,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
      color: Color(0xFFFFFFFF),
      letterSpacing: 0.01,
    ),
  );
}