
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/widgets/dialog/showLogoutDialog.dart';
import 'widgets/my_page_out_button.dart';
import 'widgets/my_page_row_button_line.dart';

class OutButtonList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      // 상자 만들기
      width: 130.w,
      height: 20.h,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 로그아웃
            OutButton(
              buttonText: "로그아웃",
              onTap: (){
                print("로그아웃 버튼 클릭!");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RecentErrand()));
                ShowLogoutDialog();
              },
            ),
            RowButtonLine(rowLineHeight: 10.h),
            // 회원탈퇴
            OutButton(
              buttonText: "회원탈퇴",
              onTap: (){
                print("회원탈퇴 버튼 클릭!");
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