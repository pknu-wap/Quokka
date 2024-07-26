import 'package:flutter/material.dart';
import 'package:front/screens/main/my_page/my_page/my_page_user.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCenter(
        title: '마이페이지',
        onBackPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          children: [
            // 사용자
            MyPageUser(),
            // 버튼 목록
            // 설정 목록
            // 로그아웃, 회원탈퇴 버튼
          ],
        ),
      ),
    );
  }
}