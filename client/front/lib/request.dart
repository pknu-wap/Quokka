import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'map.dart';


// import 'package:http/http.dart' as http; // 백엔드와 연동 시 필요
import 'dart:convert';

import 'package:front/main.dart';
// import 'main_post_page.dart'; // +버튼 클릭 시

//현재 화면에서 뒤로가기
class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _RequestState extends State<Request> {
  TextEditingController titleController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  // 텍스트 필드 변수 선언
  bool isTitleEnabled = false;
  bool isDestinationEnabled = false;
  bool isPriceEnabled = false;
  bool isRequestEnabled = false;

  // 일정 토글 버튼 변수 선언
  bool isImmediately = true; // 맨 처음 고정 값
  bool isReservation = false;
  bool isDetailVisible = false; // 예약 버튼 클릭 시 상세 시간 설정
  late List<bool> isSelected1 = [isImmediately, isReservation];

  // 위 두 변수를 닮을 리스트 -> 토글 버튼 위젯의 토글 선택 여부 담당

  // 일정 상세 시간 변수 선언
  int _selectedHour = 0; // 선택된 시간 저장
  int _selectedMinute = 0; // 선택된 분 저장

  // 결제 방법 토글 버튼 변수 선언
  bool isAccountTransfer = true;
  bool isCash = false;
  late List<bool> isSelected2 = [isAccountTransfer, isCash];

  bool isCompletedEnabled = false; // 작성 완료 버튼

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    titleController.addListener(updateTitleState);
    destinationController.addListener(updateDestinationState);
    priceController.addListener(updatePriceState);
    requestController.addListener(updateRequestState);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    titleController.dispose();
    destinationController.dispose();
    priceController.dispose();
    requestController.dispose();
    super.dispose();
  }

  // 닉네임 확인
  void updateTitleState() {
    // 중복확인 입력란의 텍스트 변경 감지하여 이메일 전성 버튼의 활성화 상태 업데이트
    setState(() {
      isTitleEnabled = titleController.text.isNotEmpty;
    });
  }

  void updateDestinationState() {
    setState(() {
      isDestinationEnabled = destinationController.text.isNotEmpty;
    });
  }

  void updatePriceState() {
    // 비밀번호 확인 입력란의 텍스트 변경 감지하여 확인 버튼의 활성화 상태 업데이트
    setState(() {
      isPriceEnabled = priceController.text.isNotEmpty;
    });
  }

  void updateRequestState() {
    // 비밀번호 확인 입력란의 텍스트 변경 감지하여 확인 버튼의 활성화 상태 업데이트
    setState(() {
      isRequestEnabled = requestController.text.isNotEmpty;
    });
  }

  void toggleSelect1(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected1.length; index++) {
        if (index == newindex) {
          isSelected1[index] = true;
          if (index == 1) {
            // 예약 버튼을 눌렀을 때
            isDetailVisible = true;
          } else {
            // 즉시 버튼을 눌렀을 때
            isDetailVisible = false;
          }
        } else {
          isSelected1[index] = false;
        }
      }
    });
  }

  void toggleSelect2(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected2.length; index++) {
        if (index == newindex) {
          isSelected2[index] = true;
        } else {
          isSelected2[index] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 19.0, top: 34.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      '요청서 작성하기',
                      style: TextStyle(
                        fontFamily: 'Paybooc',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111111),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 34),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          '제목',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 300),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 22.0, right: 20.0, top: 9.0),
                width: 318,
                height: 31,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff2D2D2D), // 테두리 색상
                      width: 0.5 // 테두리 굵기
                      ),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Color(0xffFFFFFF), // 텍스트 필드 배경색
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 7.5, left: 10, right: 10),
                  child: TextField(
                    controller: titleController,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.01,
                      color: Color(0xff252525),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),

              // 일정 텍스트
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          '일정',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 121),
                      child: Text(
                        '예약은 최대 ?시간 이후까지 가능해요.',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: 0.01,
                          color: Color(0xff111111),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7, left: 22),
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
                                '즉시',
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
                                '예약',
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
                    if (isDetailVisible)
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
              ),
              // 도착지 텍스트
              Container(
                margin: EdgeInsets.only(top: 27),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          '도착지',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 289),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 도착지 텍스트 필드
              GestureDetector(
                onTap: () {
                  print("도착지 텍스트 필드 클릭");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KakaoMapTest()), // 지도 페이지로 이동
                  );
                },
                child: Container(
                margin: EdgeInsets.only(top: 6),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: 318,
                      height: 31,
                      decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                                    ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 7.5, left: 7.5, right: 7.5),
                            child: TextField(
                              controller: destinationController,
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                letterSpacing: 0.01,
                                color: Color(0xff373737),
                              ),
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.only(left: 11.58),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                              enabled: isCompletedEnabled,
                            ),
                          ),
                        ),

                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 9, top: 3),
                          color: Colors.transparent,
                          child: Icon(
                              Icons.search,
                            color: Color(0xffB9BCC6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

              // 상세 주소 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 22.0, right: 20.0, top: 6.0),
                width: 318,
                height: 31,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                          ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color(0xffFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 9.75, left: 8, right: 8),
                  child: TextField(
                    controller: detailAddressController,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.01,
                      color: Color(0xff373737),
                    ),
                    decoration: InputDecoration(
                      hintText: '상세 주소를 입력해주세요. ex) 중앙도서관 1층 데스크',
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: 0.01,
                        color: Color(0xff878787),
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),

              // 심부름 값 텍스트, 결제 방법 텍스트
              Container(
                margin: EdgeInsets.only(top: 19.5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          '심부름 값',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 70),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Text(
                        '결제 방법',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xff111111),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 142),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 심부름 값 텍스트 필드, 결제 방법 토글 버튼
              Container(
                margin: EdgeInsets.only(top: 8, left: 22.0),
                child: Row(
                  children: [
                    Expanded(
                      // 심부름 값 텍스트 필드
                      child: Container(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Container(
                              width: 104,
                              height: 31,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                color: Color(0xffFFFFFF),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 1, left: 27, right: 7.5),
                                child: TextField(
                                  controller: priceController,
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    letterSpacing: 0.01,
                                    color: Color(0xff373737),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),

                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.only(left: 9, top: 6),
                                  color: Colors.transparent,
                                  child: Image.asset(
                                              'assets/images/₩.png',
                                              color: Color(0xff7C7C7C),
                                              width: 11,
                                              height: 14,
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 119,
                      height: 31,
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
                    ),
                  ],
                ),
              ),

              // 요청사항 텍스트
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          '요청사항',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 275),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 요청사항 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 22.0, right: 20.0, top: 8.0),
                width: 318,
                height: 67.4,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                          ),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Color(0xffFFFFFF),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 2, left: 10, right: 10),
                  // hintText Padding이 이상해서 임의로 설정
                  child: TextField(
                    controller: requestController,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.01,
                      color: Color(0xff111111),
                    ),
                    decoration: InputDecoration(
                      hintText:
                          '심부름 내용에 대한 간단한 설명을 적어주세요.\nex) 한 잔만 시럽 2번 추가해 주세요.',
                      hintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: 0.01,
                        color: Color(0xff878787),
                      ),
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    // 입력 텍스트가 필요한 만큼 자동으로 늘어남
                    minLines: 1,
                    // 최소한 1줄 표시
                    keyboardType: TextInputType.multiline, // 여러 줄 입력 가능하도록 하기
                  ),
                ),
              ),
              // 작성 완료 버튼 만들기
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 21.0, top: 110.6),
                child: ElevatedButton(
                  onPressed: () {
                    print("요청서 작성 완료");
                  },
                  style: ButtonStyle(
                    // 버튼의 배경색 변경하기
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (isTitleEnabled &&
                          isDestinationEnabled &&
                          isPriceEnabled &&
                          isRequestEnabled) {
                        return Color(
                            0xFF7C3D1A); // 활성화된 배경색(모든 텍스트 필드 비어있지 않은 경우)
                      } else {
                        return Color(
                            0xFFBD9E8C); // 비활성화 배경색(하나의 텍스트 필드라도 비어있는 경우)
                      }
                    }),
                    // 버튼의 크기 정하기
                    minimumSize: MaterialStateProperty.all<Size>(Size(318, 41)),
                    // 버튼의 모양 변경하기
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5), // 원하는 모양에 따라 BorderRadius 조절
                      ),
                    ),
                  ),
                  child: Text(
                    '작성 완료',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
