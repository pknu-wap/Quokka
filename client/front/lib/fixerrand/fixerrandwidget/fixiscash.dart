import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FixIsCash extends StatefulWidget{
  final bool isCash;
  final setIsCashParentState;
  FixIsCash({
    Key? key,
    required this.isCash,
    required this.setIsCashParentState
  }) : super(key: key);

  @override
  State createState() => _FixIsCashState();
}


class _FixIsCashState extends State<FixIsCash>{
  // 결제 방법 토글 버튼 변수 선언
  bool isAccountTransfer = true;
  late bool isCash = false;
  late List<bool> isSelected2 = [isAccountTransfer, isCash];

  // 토글 버튼(결제 방법)
  void toggleSelect2(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected2.length; index++) {
        if (index == newindex) {
          isSelected2[index] = true;
        } else {
          isSelected2[index] = false;
        }
      }
      widget.setIsCashParentState(isSelected2);
    });
  }

  void initializeToggle2() {
    if (widget.isCash) { // true라면, 현금 버튼
      isSelected2 = [false, true];
    } else { // false라면, 계좌이체 버튼
      isSelected2 = [true, false];
    }
  }

  @override
  void initState(){
    super.initState();
    initializeToggle2();
  }

  @override
  Widget build(BuildContext context){
    return Container(
        width: 119,
        height: 38,
        // 토글 버튼 만들기
        margin: EdgeInsets.only(right: 86),
        child: ToggleButtons(
          color: Color(0xff2E2E2E),
          // 선택되지 않은 버튼 텍스트 색상

          borderColor: Colors.grey,
          // 토글 버튼 테두리 색상
          borderWidth: 0.5,
          borderRadius: BorderRadius.circular(5.0),

          selectedColor: Color(0xffC77749),
          // 선택된 버튼 텍스트 색상
          fillColor: Color(0xffFFFFFF),
          // 선택된 버튼 배경색
          selectedBorderColor: Color(0xffC77749),
          // 선택된 버튼 테두리 색상

          // renderBorder: false,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Text(
                '계좌이체',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  letterSpacing: 0.01,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                '현금',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  letterSpacing: 0.01,
                ),
              ),
            ),
          ],
          isSelected: isSelected2,
          onPressed: toggleSelect2,
        ),
    );
  }
}