import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text smallGrayText(String text) //닉네임, 평점에 사용됩니다.
{
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
      fontSize: 12.sp,
      letterSpacing: 0.01,
      color: const Color(0xff7E7E7E),
   ),
  );
}