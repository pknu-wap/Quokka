import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/my_page_column_button.dart';
import 'widgets/my_page_column_button_line.dart';

class ColumnButtonList extends StatefulWidget {
  @override
  _ColumnButtonListState createState() => _ColumnButtonListState();
}

class _ColumnButtonListState extends State<ColumnButtonList> {
  bool isPushNotificationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.h),
      // 상자 만들기
      width: 330.w,
      height: 337.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xffA9A9A9),
            width: 0.5,
          )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 푸시 알림
            ColumnButton(
              columnButtonText: "푸시 알림",
              onTap: (){
                print("푸시 알림 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
              hasToggle: true,
              initialToggleValue: isPushNotificationEnabled,
            ),
            ColumnButtonLine(),
            // 알림음 설정
            ColumnButton(
              columnButtonText: "알림음 설정",
              onTap: (){
                print("알림음 설정 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
            ColumnButtonLine(),
            // 고객센터
            ColumnButton(
              columnButtonText: "고객센터",
              onTap: (){
                print("고객센터 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
            ColumnButtonLine(),
            // 공지사항
            ColumnButton(
              columnButtonText: "공지사항",
              onTap: (){
                print("공지사항 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
            ColumnButtonLine(),
            // 개인정보 수집 및 이용
            ColumnButton(
              columnButtonText: "개인정보 수집 및 이용",
              onTap: (){
                print("개인정보 수집 및 이용 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
              },
            ),
            ColumnButtonLine(),
            // 버전 정보
            ColumnButton(
              columnButtonText: "버전 정보",
              onTap: (){
                print("버전 정보 버튼 클릭!");
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