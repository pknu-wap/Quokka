import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class NameLength5More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
    return Container(
      // margin: EdgeInsets.only(top: 17.15),
      child: Stack(
        children: [
          // 캐릭터 도장
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(top: 12, right: 40),
                  child: Image.asset("assets/images/big_stamp.png")
              )
          ),

        ],
      ),
    );
  }
}