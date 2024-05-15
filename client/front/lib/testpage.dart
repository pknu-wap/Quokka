import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'main_post_page.dart';
class test extends StatelessWidget {
  final int errandNo;
  const test({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Text("$errandNo", style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            fontSize: 100,
            color: Color(0xFF404040),
          )),
        )
      )
    );
  }
}
