import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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

Container filterButton2(Color borderColor, Color textColor, String text){
  return Container(
    width: 134.w, height: 32.h,
    margin: EdgeInsets.only(
      left: 16.w, top: 20.h,
    ),
    child: Stack(
      children: [
        Positioned(
          left: 0.w, top: 0.h,
          child: Container(
            width: 134.w, height: 32.h,
            decoration: BoxDecoration(
              color: Color(0xFFFBFBFB),
              border: Border.all(
                color: borderColor, width: 1.w,),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          left: 8.w, top: 5.h,
          child: SvgPicture.asset(
            text == '수행한 심부름'
                ? 'assets/images/running_errand.svg'
                : 'assets/images/requesting_errand.svg'
            , width: 23.w, height: 21.h,
         ),
        ),
        Positioned(
          left: 35.w, top: 8.h,
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



