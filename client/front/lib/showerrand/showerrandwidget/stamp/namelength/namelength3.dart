import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class NameLength3 extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;

  NameLength3({
    required this.name1,
    required this.name2,
    required this.name3,
});

  @override
  Widget build(BuildContext context) {
    // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
    return Container(
      // margin: EdgeInsets.only(top: 17.15),
      child: Stack(
        children: [
          // 심부름 하는 사람 이름 첫 번째 글자
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 6.52, right: 55),
                child: Transform.rotate(
                    angle: 9.77 * math.pi / 180,
                    child: Text(
                      name1,
                      style: TextStyle(
                        fontFamily: 'Cafe24Oneprettynight',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        letterSpacing: 0.00,
                        color: Color(0xffCE1111),
                      ),
                    )
                ),
              )
          ),
          // 심부름 하는 사람 이름 두 번째 글자
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 9.3, right: 38),
                child: Transform.rotate(
                    angle: 9.77 * math.pi / 180,
                    child: Text(
                      name2,
                      style: TextStyle(
                        fontFamily: 'Cafe24Oneprettynight',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        letterSpacing: 0.00,
                        color: Color(0xffCE1111),
                      ),
                    )
                ),
              )
          ),
          // 심부름 하는 사람 이름 세 번째 글자
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 22.9, right: 58),
                child: Transform.rotate(
                    angle: 9.77 * math.pi / 180,
                    child: Text(
                      name3,
                      style: TextStyle(
                        fontFamily: 'Cafe24Oneprettynight',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        letterSpacing: 0.00,
                        color: Color(0xffCE1111),
                      ),
                    )
                ),
              )
          ),
          // 도장 그림
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(top: 28.58, right: 40.53),
                  child: Image.asset("assets/images/stamp.png")
              )
          ),

        ],
      ),
    );
  }
}