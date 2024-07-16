import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ButtonStyle brownButton320(Color color){
  return ButtonStyle(
// 버튼의 배경색 변경하기
    backgroundColor: MaterialStateProperty.all<Color>(color),
    minimumSize:
    MaterialStateProperty.all<Size>(Size(320.w, 43.h)),
// 버튼의 모양 변경하기
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // 원하는 모양에 따라 BorderRadius 조절
      ),
    ),
  );
}

ButtonStyle brownButton318(Color color){
  return ButtonStyle(
// 버튼의 배경색 변경하기
    backgroundColor: MaterialStateProperty.all<Color>(color),
    minimumSize:
    MaterialStateProperty.all<Size>(Size(318.w, 45.h)),
// 버튼의 모양 변경하기
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // 원하는 모양에 따라 BorderRadius 조절
      ),
    ),
  );
}

