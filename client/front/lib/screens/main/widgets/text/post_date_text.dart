import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Text dateText(String errandDate) //심부름 보수에 사용됩니다.
{
  return Text(errandDate, style: TextStyle(
    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400, fontSize: 11.sp,
    letterSpacing: 0.01, color: const Color(0xff434343),
  ),
  );
}