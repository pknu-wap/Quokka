import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text appBarText(String text)
{
  return Text(
    text,
    style: TextStyle(
        color: Color(0xFF111111),
        fontFamily: 'Paybooc',
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        letterSpacing: 0.01
    ),
    textAlign: TextAlign.center,
  );
}