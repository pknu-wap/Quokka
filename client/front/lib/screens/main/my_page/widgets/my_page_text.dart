import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text title(String text)
{
  return Text(
    text,
    style: TextStyle(
      color: Color(0xFF373737),
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
      letterSpacing: 0.01,
    ),
  );
}

Text greyText(String text, double fontSize)
{
  return Text(
    text,
    style: TextStyle(
      color: Color(0xFF7E7E7E),
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400, // Regular
      fontSize: fontSize.sp,
      letterSpacing: 0.001,
    ),
  );
}