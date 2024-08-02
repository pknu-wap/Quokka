// 회원 정보 수정
import 'package:flutter/material.dart';
import 'package:front/widgets/bar/navigation_bar.dart'; //insert overlay 하는데 필요함
import '../../errand_list/errand_list.dart'; //overlay 없애는데 필요함
import 'user_info_column_list.dart';
import 'user_info_user_image.dart';
import 'widgets/my_page_app_bar.dart';

class MyPageUserInfo extends StatefulWidget {
  @override
  _MyPageUserInfoState createState() => _MyPageUserInfoState();
}

class _MyPageUserInfoState extends State<MyPageUserInfo> {

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    //errand_list에서 생성한 overlay를 제거함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) async {
      if (didPop) {
        insertOverlay(context); //뒤로가기 하면 overlay 생기게 다시 넣어줌
        return;
      }
      Navigator.of(context).pop();
    },
      child: Scaffold(
      appBar: MyPageAppBar(),
      body: Center(
        child: Column(
          children: [
            UserImage(),
            ColumnList(),
          ],
        ),
      ),
     )
    );
  }
}