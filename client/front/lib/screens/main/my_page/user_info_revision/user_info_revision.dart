import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';
import 'user_info_revision_container.dart';

class UserInfoRevision extends StatelessWidget {
  final String nickName;
  final String name;
  final String email;
  final String password;

  UserInfoRevision({
    Key? key,
    required this.nickName,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nickNameController = TextEditingController(text: nickName);
    final TextEditingController _nameController = TextEditingController(text: name);
    final TextEditingController _emailController = TextEditingController(text: email);
    final TextEditingController _passwordController = TextEditingController(text: password);
    return Scaffold(
      appBar: CustomAppBarCenter(
        title: '회원 정보 수정',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            // 닉네임
            RevisionContainer(
              controller: _nickNameController,
              labelText: '닉네임',
              keyboardType: TextInputType.text,
            ),
            // 이름
            RevisionContainer(
              controller: _nameController,
              labelText: '이름',
              keyboardType: TextInputType.text,
              grayText: "수정이 불가합니다.",
            ),
            SizedBox(
              height: 10.h,
            ),
            // 계정
            RevisionContainer(
              controller: _emailController,
              labelText: '계정',
              keyboardType: TextInputType.emailAddress,
              grayText: "수정이 불가합니다.",
            ),
            SizedBox(
              height: 10.h,
            ),
            // 비밀번호
            RevisionContainer(
              controller: _passwordController,
              labelText: '비밀번호',
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
