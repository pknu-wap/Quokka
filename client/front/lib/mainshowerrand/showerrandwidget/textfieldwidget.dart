import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget{
  final String realName;

  TextFieldWidget({
    required this.realName,
});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                realName == "김수현" ? '       ${realName}       ' : '              ',  // 연동 시, "김수현" 부분 수정
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