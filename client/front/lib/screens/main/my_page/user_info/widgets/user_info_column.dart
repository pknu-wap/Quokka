

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoColumn extends StatefulWidget {
  final String textName;
  final String textInfo;

  const UserInfoColumn({
    Key? key,
    required this.textName,
    required this.textInfo,
  }) : super(key: key);

  @override
  _UserInfoColumnState createState() => _UserInfoColumnState();
}

class _UserInfoColumnState extends State<UserInfoColumn> {

  @override
  void initState() {
    super.initState();
  }

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
            widget.textName,
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
            widget.textInfo,
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