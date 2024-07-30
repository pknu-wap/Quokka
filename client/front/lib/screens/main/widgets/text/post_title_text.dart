import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text titleText(String text) //게시글 제목에 사용됩니다.
{
  return  Text
     (text,
      style: TextStyle(
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      letterSpacing: 0.01,
      color: const Color(0xff111111)
  )
  );
}