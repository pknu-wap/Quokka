import 'package:flutter/cupertino.dart';
import 'package:front/mainshowerrand/showerrandwidget/stamp/namelength3.dart';
import 'package:front/mainshowerrand/showerrandwidget/stamp/namelength4.dart';

class Stamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
    return Container(
      // margin: EdgeInsets.only(top: 17.15),
      child: Stack(
        children: [
          // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.only(top: 5.15, right: 32),
                  child: Image.asset("assets/images/Rectangle3.png")
              )
          ),
          // 심부름 하는 사람 이름 길이 3자
          // Namelength3(),
          // 심부름 하는 사람 이름 길이 4자
          Namelength4(),


        ],
      ),
    );
  }
}