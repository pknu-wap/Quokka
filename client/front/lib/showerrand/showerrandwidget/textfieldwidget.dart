import 'dart:convert';

import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget{
  final String realName;

  TextFieldWidget({
    required this.realName,
});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
    child: Column(
    children:[
        Container(
          margin: EdgeInsets.only(left: 2),
          child: Transform.translate(
            offset: Offset(0, -3),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    color: Color(0xff111111),
                    width: 0.5)), // 밑줄 스타일링
              ),
              child: Text(
                realName != "" ? '       ${utf8.decode(realName.runes.toList())}       ' : '              ',  // 연동
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  letterSpacing: 0.00,
                  color: Color(0xff111111),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}