import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
var priceFormat = NumberFormat('###,###,###,###');
Text priceText(int reward) //심부름 보수에 사용됩니다.
{
  return Text("\u20A9${priceFormat.format(reward)}", style: TextStyle(
    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500, fontSize: 13.sp,
    letterSpacing: 0.01, color: const Color(0xffEC5147),
  ),
  );
}