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