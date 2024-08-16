import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text revisionGrayText(String text)
{
  return Text(
    text,
    style: TextStyle(
      color: Color(0xFF9E9E9E),
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400, // Regular
      fontSize: 11.sp,
      letterSpacing: 0.001,
    ),
  );
}