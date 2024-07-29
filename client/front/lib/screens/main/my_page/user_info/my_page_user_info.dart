// 회원 정보 수정
import 'package:flutter/material.dart';

import 'user_info_user_image.dart';
import 'widgets/my_page_app_bar.dart';

class MyPageUserInfo extends StatefulWidget {
  @override
  _MyPageUserInfoState createState() => _MyPageUserInfoState();
}

class _MyPageUserInfoState extends State<MyPageUserInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyPageAppBar(),
      body: Center(
        child: Column(
          children: [
            UserImage(),
          ],
        ),
      ),
    );
  }
}