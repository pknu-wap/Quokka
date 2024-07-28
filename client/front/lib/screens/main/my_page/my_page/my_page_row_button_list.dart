import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/my_page_row_button_line.dart';
import 'widgets/my_page_row_button.dart';

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
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 최근 본 심부름
            RowButton(
              buttonText: "최근 본 심부름",
              buttonIcon: "assets/images/recent_errand.svg",
              onTap: (){
                print("최근 본 심부름 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
            // 구분선
            RowButtonLine(),
            // 즐겨찾기
            RowButton(
              buttonText: "즐겨찾기",
              buttonIcon: "assets/images/book_mark.svg",
              onTap: (){
                print("즐겨찾기 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
            // 구분선
            RowButtonLine(),
            // 찜 목록
            RowButton(
              buttonText: "찜 목록",
              buttonIcon: "assets/images/steamed_list.svg",
              onTap: (){
                print("찜 목록 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
          ],
        ),
      ),
    );

    // 안에, 가로로 정렬(버튼 세 개 만들기)
    // 각각을 세로로 정렬(텍스트, 이미지)
  }
}