import 'package:flutter/material.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';
import 'package:front/widgets/text/app_bar_text.dart';

class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: appBarText('회원 정보'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff6B6B6B),
          size: 24.0,
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
          onPressed: (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyPageUserInfoRevision()));
          },
          child: title('수정'),
        ),
      ],
      centerTitle: true, // 타이틀 중앙 정렬
      backgroundColor: Colors.white, // 앱바, 상단 네비게이션 바 배경색 변경
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}