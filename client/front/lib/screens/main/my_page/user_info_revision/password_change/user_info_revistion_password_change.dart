import 'package:flutter/material.dart';

class PasswordChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("비밀번호 변경"),
      ),
      body: Center(
        child: Text(
          "여기서 비밀번호를 변경할 수 있습니다.",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
