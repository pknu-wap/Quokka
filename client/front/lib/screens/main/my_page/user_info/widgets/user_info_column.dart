import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoColumn extends StatelessWidget {
  final String textName;
  final String textInfo;
  final bool obscureText;

  const UserInfoColumn({
    Key? key,
    required this.textName,
    required this.textInfo,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 304.w,
      height: 50.h,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 텍스트 이름
          Text(
            textName,
            style: TextStyle(
              color: Color(0xff373737),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400, // Regular
              fontFamily: "Pretendard",
              letterSpacing: 0.00,
            ),
          ),
          // 텍스트 정보
          Text(
            obscureText ? '*' * textInfo.length : textInfo,
            style: TextStyle(
              color: Color(0xff7E7E7E),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400, // Regular
              fontFamily: "Pretendard",
              letterSpacing: 0.001,
            ),
          ),
        ],
      ),
    );
  }
}