import 'package:flutter/cupertino.dart';
import 'package:front/mainshowerrand/showerrandwidget/stamp/namelength3.dart';
import 'package:front/mainshowerrand/showerrandwidget/stamp/namelength4.dart';
import 'package:front/mainshowerrand/showerrandwidget/stamp/namelength5more.dart';

class Stamp extends StatelessWidget {
  String realName = "김수현"; // 연동 시, 수정 필요
  late String name1 = realName[0];
  late String name2 = realName[1];
  late String name3 = realName[2];
  late String name4 = realName[3];

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

          if(realName.length == 3)
          // 심부름 하는 사람 이름 길이 3자
          NameLength3(
            name1: name1,
            name2: name2,
            name3: name3,
          ),
          if(realName.length == 4)
          // 심부름 하는 사람 이름 길이 4자
          NameLength4(
            name1: name1,
            name2: name2,
            name3: name3,
            name4: name4,
          ),
          if(realName.length >= 5)
          // 심부름 하는 사람 이름 길이 5자 이상
          NameLength5More(),


        ],
      ),
    );
  }
}