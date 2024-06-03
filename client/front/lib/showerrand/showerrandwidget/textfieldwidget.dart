import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget {
  final String realName;

  TextFieldWidget({
    required this.realName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 4, left: 2),
              child: Text(
                "____________",
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Align(
            alignment: Alignment.center,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 350),
            margin: EdgeInsets.only(top: 3, left: 2,),
            child: realName != "" ? FutureBuilder(
              future: Future.delayed(Duration(milliseconds:700)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                utf8.decode(realName.runes.toList()),
                speed: Duration(milliseconds: 200),
                textStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  letterSpacing: 0.00,
                  color: Color(0xff111111),
                ),
              ),
            ],
            totalRepeatCount: 1,
          );
        } else {
          return SizedBox.shrink();
        }
      }):
            Text(
              '',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w300,
                fontSize: 11,
                letterSpacing: 0.00,
                color: Color(0xff111111),
              ),
            ),
            // ),
          ),
          ),
      ]
    )
        ],
      ),
    );



    //   AnimatedContainer(
    //   duration: Duration(milliseconds: 500),
    //   // child: Transform.translate(
    //   // offset: Offset(0, -3),
    //       margin: EdgeInsets.only(left: 2),
    //       decoration: BoxDecoration(
    //         border: Border(
    //           bottom: BorderSide(
    //             color: Color(0xff111111),
    //             width: 0.5,
    //           ), // 밑줄 스타일링
    //         ),
    //       ),
    //       child: realName != "" ?
    //           AnimatedTextKit(animatedTexts: [
    //             TypewriterAnimatedText(
    //                 utf8.decode(realName.runes.toList()),
    //               speed: Duration(milliseconds: 200),
    //             ),
    //           ],
    //             totalRepeatCount: 1,
    //           ) :
    //       Text(
    //         '',
    //         style: TextStyle(
    //           fontFamily: 'Pretendard',
    //           fontWeight: FontWeight.w300,
    //           fontSize: 11,
    //           letterSpacing: 0.00,
    //           color: Color(0xff111111),
    //         ),
    //       ),
    //     // ),
    // );
  }
}
