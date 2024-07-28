import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowButtonList extends StatefulWidget {
  @override
  _RowButtonListState createState() => _RowButtonListState();
}

class _RowButtonListState extends State<RowButtonList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),
      // 상자 만들기
      width: 330.w,
      height: 79.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xffA9A9A9),
            width: 0.5,
          )
      ),
    );

    // 안에, 가로로 정렬(버튼 세 개 만들기)
    // 각각을 세로로 정렬(텍스트, 이미지)
  }
}