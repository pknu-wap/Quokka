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

Text subTitle(String text)
{
  return Text(
    text,
    style: TextStyle(
      color: Color(0xFF9E9E9E),
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400,
      fontSize: 11.sp,
      letterSpacing: 0.01,
    ),
  );
}