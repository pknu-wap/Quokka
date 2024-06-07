import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/fixerrand/fixerrand.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FixDue extends StatefulWidget{
  final String due; // 일정으로 정한 시간
  final setDayParentState;
  final setHourParentState;
  final setMinuteParentState;
  FixDue({
    Key? key,
    required this.due,
    required this.setDayParentState, required this.setHourParentState, required this.setMinuteParentState
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
      widget.setDayParentState(isSelected1);
    });
  }
  /*
  ParentState parent = context.findAncestorStateOfType<ParentState>();
   */

  void initializeToggle1() {
    DateTime dueDate = DateTime.parse(widget.due); // 심부름 일정 시간 -> 시간이 더 나중임
    DateTime currentDate = DateTime.now(); // 수정하기 버튼을 누른 현재 시각
    // difference가 아니라 현재 시간에서 due를 뺀 값을 음수 양수에 따라 구분하기

    // (currentDate - dueDate)
    int yearDifference = currentDate.year - dueDate.year; // 년도 차이
    int monthDifference = currentDate.month - dueDate.month; // 월 차이
    int dayDifference = currentDate.day - dueDate.day; // 일 차이
    int hourDifference = currentDate.hour - dueDate.hour; // 시간 차이
    int minuteDifference = currentDate.minute - dueDate.minute; // 분 차이
    int secondDifference = currentDate.second - dueDate.second; // 초 차이

    // 현재 시간 - due > 0 라면 날짜 지남
    if (yearDifference > 0 ||
        (yearDifference == 0 && monthDifference > 0) ||
        (yearDifference == 0 && monthDifference == 0 && dayDifference > 0) ||
        (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 &&
            hourDifference > 0) ||
        (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 &&
            hourDifference == 0 && minuteDifference > 0) ||
        (yearDifference == 0 && monthDifference == 0 && dayDifference == 0 &&
            hourDifference == 0 && minuteDifference == 0 &&
            secondDifference > 0)) {
      // 1. 시간 지났을 때,(오늘, 내일) -> 오늘, 00시
      isSelected1 = [true, false]; // 오늘
      _selectedHour = 0;
      _selectedMinute = 0;
      // dueDate = DateTime(currentDate.year, currentDate.month, currentDate.day, currentDate.hour, currentDate.minute);
    } else { // 현재 시간 - due < 0 라면 날짜 지나기 전,
      if (dayDifference == 0) { // 2. 오늘로 심부름 지정 -> 시간이 안 지났어 -> 오늘
        isSelected1 = [true, false]; // 오늘
        _selectedHour = dueDate.hour;
        _selectedMinute = dueDate.minute;
      } else if (dayDifference == -1) { // 3. 내일로 심부름 지정 -> 시간이 안 지났어 -> 당일(오늘) 수정 -> 내일
          isSelected1 = [false, true]; // 내일
          _selectedHour = dueDate.hour;
          _selectedMinute = dueDate.minute;
      }
    }
    widget.setDayParentState(isSelected1);
    widget.setHourParentState(_selectedHour);
    widget.setMinuteParentState(_selectedMinute);
  }


    @override
    void initState() {
      super.initState();
      initializeToggle1();
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 6.h, left: 22.w),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 106.w,
                height: 38.h,
                // 토글 버튼 만들기
                margin: EdgeInsets.only(left: 0.w),
                child: ToggleButtons(
                  color: Color(0xff2E2E2E),
                  // 선택되지 않은 버튼 텍스트 색상
                  // 선택되지 않은 버튼 배경색
                  borderColor: Colors.grey,
                  // 토글 버튼 테두리 색상
                  borderWidth: 0.5.w,
                  borderRadius: BorderRadius.circular(5.0),

                  selectedColor: Color(0xffC77749),
                  // 선택된 버튼 텍스트 색상
                  fillColor: Color(0xffFFFFFF),
                  // 선택된 버튼 배경색
                  selectedBorderColor: Color(0xffC77749),
                  // 선택된 버튼 테두리 색상

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        '오늘',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          letterSpacing: 0.01,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        '내일',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
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
              margin: EdgeInsets.only(right: 51.w),
              width: 165.28.w,
              height: 38.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffA9A9A9), // 박스 테두리 색상
                  width: 0.5.w, // 테두리 굵기
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)),
                color: Color(0xffFFFFFF), // 박스 배경 색상
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: DropdownButton<int>(
                      underline: Container(),
                      // dropdownButton 밑줄 제거
                      value: _selectedHour,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedHour = newValue!;
                          widget.setHourParentState(_selectedHour);
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_down,
                          size: 17.sp, color: Color(0xff808080)),
                      items: List.generate(24, (index) {
                        // 0~23시
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              letterSpacing: 0.01,
                              color: Color(0xffC77749),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: Text(
                      '시',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        letterSpacing: 0.01,
                        color: Color(0xff4F4F4F),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: DropdownButton<int>(
                      underline: Container(),
                      // dropdownButton 밑줄 제거
                      value: _selectedMinute,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedMinute = newValue!;
                          widget.setMinuteParentState(_selectedMinute);
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_down,
                          size: 17.sp, color: Color(0xff808080)),
                      items: List.generate(60, (index) {
                        // 0~59분
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              letterSpacing: 0.01,
                              color: Color(0xffC77749),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 2.w),
                    child: Text(
                      '분',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        letterSpacing: 0.01,
                        color: Color(0xff4F4F4F),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.w),
                    child: Text(
                      '까지',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
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