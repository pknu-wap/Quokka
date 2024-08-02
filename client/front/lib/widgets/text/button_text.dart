import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 갈색 버튼 흰색 텍스트
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

// 흰색 버튼 검정 텍스트
Text whiteButtonText(String text)
{
  return Text(
    text,
    style: TextStyle(
      fontSize: 15.sp,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600, //Semi-bold
      color: Color(0xFF3E3E3E),
      letterSpacing: 0.01,
    ),
  );
}