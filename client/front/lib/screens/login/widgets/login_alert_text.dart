import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text loginAlertText(String alertMessage){
  return Text(
    alertMessage,
    style: TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400,
      color: Color(0xFFEC5147),
    ),
  );
}