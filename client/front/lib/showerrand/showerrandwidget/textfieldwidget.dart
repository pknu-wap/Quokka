import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget {
  final String realName;

  TextFieldWidget({
    required this.realName,
  });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Transform.translate(
//         offset: Offset(0, -3),
//         child: Container(
//           margin: EdgeInsets.only(left: 2),
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Color(0xff111111),
//                 width: 0.5,
//               ), // 밑줄 스타일링
//             ),
//           ),
//           child: Text(
//             realName != "" ?
//             '        ${utf8.decode(realName.runes.toList())}       ' : '              ',
//             style: TextStyle(
//               fontFamily: 'Pretendard',
//               fontWeight: FontWeight.w300,
//               fontSize: 11,
//               letterSpacing: 0.00,
//               color: Color(0xff111111),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.translate(
        offset: Offset(0, -3),
        child: Container(
          margin: EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xff111111),
                width: 0.5,
              ), // 밑줄 스타일링
            ),
          ),
          child: realName != "" ? _buildAnimatedText() : SizedBox(), // 조건부로 애니메이션 적용
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          '        ${utf8.decode(realName.runes.toList())}       ',
          textStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w300,
            fontSize: 11,
            letterSpacing: 0.00,
            color: Color(0xff111111),
          ),
        ),
      ],
    );
  }
}