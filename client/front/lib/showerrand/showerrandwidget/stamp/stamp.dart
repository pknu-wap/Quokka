import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'namelength/namelength2.dart';
import 'namelength/namelength3.dart';
import 'namelength/namelength4.dart';
import 'namelength/namelength5more.dart';

class Stamp extends StatelessWidget {
  final String realName;
  late String name1 = realName[0];
  late String name2 = realName[1];
  late String name3 = realName[2];
  late String name4 = realName[3];

  Stamp({
    required this.realName,
  });

  @override
  Widget build(BuildContext context) {
    // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 3700)),
      // 3.8초 지연 후 Future완료
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 1.2, end: 1.0), // 애니메이션의 시작과 끝 값
            // -> 1.2배에서 1.0배로 크기 변환
            duration: Duration(milliseconds: 700), // 애니메이션 지속 시간
            curve: Curves.easeInOut, // 애니메이션의 가속 및 감속 곡선 설정
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale, // 현재 애니메이션의 스케일 값 적용
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 350), // 지속 시간
                    curve: Curves.fastOutSlowIn, // 애니메이션의 곡선
                    child: Stack(
                      children: [
                        // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                margin: EdgeInsets.only(top: 5.15, right: 32),
                                child: Image.asset(
                                    "assets/images/Rectangle3.png"))),

                        if (realName.length == 2)
                          // 심부름 하는 사람 이름 길이 2자
                          NameLength2(name1: name1, name2: name2),

                        if (realName.length == 3)
                          // 심부름 하는 사람 이름 길이 3자
                          NameLength3(
                            name1: name1,
                            name2: name2,
                            name3: name3,
                          ),
                        if (realName.length == 4)
                          // 심부름 하는 사람 이름 길이 4자
                          NameLength4(
                            name1: name1,
                            name2: name2,
                            name3: name3,
                            name4: name4,
                          ),
                        if (realName.length == 1 || realName.length >= 5)
                          // 심부름 하는 사람 이름 길이 1자 또는 5자 이상
                          NameLength5More(),
                      ],
                    )),
              );
            },
          );
        } else {
          return SizedBox.shrink(); // Future 완료되지 않았을 때 빈 위젯 반환
        }
      },
    );
  }
}
