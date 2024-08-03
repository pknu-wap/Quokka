import 'package:flutter/material.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';

class UserInfoRevision extends StatelessWidget {

  UserInfoRevision({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCenter(
        title: '회원 정보 수정',
        onBackPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
