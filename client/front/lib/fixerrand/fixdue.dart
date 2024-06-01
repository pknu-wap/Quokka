import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FixDue extends StatefulWidget{
  final String due; // 일정 정한 시간
  final String createdDate; // 게시글 올린 시간
  FixDue({
    Key? key,
    required this.due,
    required this.createdDate,
  }) : super(key: key);

  @override
  State createState() => _FixDueState();
}


class _FixDueState extends State<FixDue>{
  // 일정 토글 버튼 변수 선언
  bool isToday = true; // 맨 처음 고정 값
  bool isTomorrow = false;
  // 위 두 변수를 닮을 리스트 -> 토글 버튼 위젯의 토글 선택 여부 담당
  late List<bool> isSelected1 = [isToday, isTomorrow];

  // 일정 상세 시간 변수 선언
  int _selectedHour = 0; // 선택된 시간 저장
  int _selectedMinute = 0; // 선택된 분 저장

  // 토글 버튼(일정)
  void toggleSelect1(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected1.length; index++) {
        if (index == newindex) {
          isSelected1[index] = true;
        } else {
          isSelected1[index] = false;
        }
      }
    });
    }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 6, left: 22),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 106,
              height: 31,
              // 토글 버튼 만들기
              margin: EdgeInsets.only(left: 0),
              child: ToggleButtons(
                color: Color(0xff2E2E2E),
                // 선택되지 않은 버튼 텍스트 색상
                // 선택되지 않은 버튼 배경색
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

                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '오늘',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: 0.01,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '내일',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: 0.01,
                      ),
                    ),
                  ),
                ],
                isSelected: isSelected1,
                onPressed: toggleSelect1,
              ),
            ),
          ),
          // 시간 상세 설정 카테고리
          Container(
            margin: EdgeInsets.only(right: 69),
            width: 146,
            height: 31,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffC77749), // 박스 테두리 색상
                width: 0.5, // 테두리 굵기
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)),
              color: Color(0xffFFFFFF), // 박스 배경 색상
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: DropdownButton<int>(
                    underline: Container(),
                    // dropdownButton 밑줄 제거
                    value: _selectedHour,
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedHour = newValue!;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down,
                        size: 17, color: Color(0xff808080)),
                    items: List.generate(24, (index) {
                      // 0~23시
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 0.01,
                            color: Color(0xffC77749),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Text(
                    '시',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.01,
                      color: Color(0xff4F4F4F),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: DropdownButton<int>(
                    underline: Container(),
                    // dropdownButton 밑줄 제거
                    value: _selectedMinute,
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedMinute = newValue!;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down,
                        size: 17, color: Color(0xff808080)),
                    items: List.generate(60, (index) {
                      // 0~59분
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 0.01,
                            color: Color(0xffC77749),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Text(
                    '분',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.01,
                      color: Color(0xff4F4F4F),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Text(
                    '까지',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.01,
                      color: Color(0xffC77749),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}