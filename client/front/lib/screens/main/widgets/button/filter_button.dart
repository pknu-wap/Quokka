import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container filterButton1(Color borderColor, Color textColor, String text){
  return Container(
    width: 70.w, height: 32.h,
    margin: EdgeInsets.only(
      left: 11.w, top: 19.h,
    ),
    child: Stack(
      children: [
        Positioned(
          left: 0.w, top: 0.h,
          child: Container(
            width: 70.w, height: 32.h,
            decoration: BoxDecoration(
              color: Color(0xFFFBFBFB),
              border: Border.all(
                color: borderColor, width: 1.w,),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ), // Text
        Positioned(
          left: 16.72.w, top: 7.72.h,
          child: Text(text, style: TextStyle(
            fontFamily: 'Pretendard',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            letterSpacing: 0.001,
            color: textColor,
          ),
          ),
        ),
      ],
    ),
  );
}



Text filterButtonText1(Color textColor, String text){
  return Text(text, style: TextStyle(
    fontFamily: 'Pretendard',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    letterSpacing: 0.001,
    color: textColor,
  ),);
}