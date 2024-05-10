import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'package:http/http.dart' as http;
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
  // 텍스트 필드 변수 선언
  bool isTitleEnabled = false;
  bool isDestinationEnabled = false;
  bool isPriceEnabled = false;

  // 일정 토글 버튼 변수 선언
  String result = "";
  bool isImmediately = true; // 맨 처음 고정 값
  bool isReservation = false;
  late List<bool> isSelected1 = [isImmediately, isReservation];
  // 위 두 변수를 닮을 리스트 -> 토글 버튼 위젯의 토글 선택 여부 담당

  // 결제 방법 토글 버튼 변수 선언
  bool isAccountTransfer = true;
  bool isCash = false;
  late List<bool> isSelected2 = [isAccountTransfer, isCash];

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    titleController.addListener(updateTitleState);
    destinationController.addListener(updateDestinationState);
    priceController.addListener(updatePriceState);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    titleController.dispose();
    destinationController.dispose();
    priceController.dispose();
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

  void toggleSelect1(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected1.length; index++) {
        if (index == newindex){
          isSelected1[index] = true;
        } else{
          isSelected1[index] = false;
        }
      }
    });
  }

  void toggleSelect2(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected2.length; index++) {
        if (index == newindex){
          isSelected2[index] = true;
        } else{
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
                        child:  Text(
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
                  color: Color(0xffF5F5F5), // 텍스트 필드 배경색
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 7.5,left: 10, right: 10),
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
                        child:  Text(
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
                        color: Color(0xff2E2E2E), // 선택되지 않은 버튼 텍스트 색상
                        borderColor: Color(0xffF2F2F2), // 토글 버튼 테두리 색상
                        borderWidth: 0.5,
                        borderRadius: BorderRadius.circular(8.0),

                        selectedColor: Color(0xffC77749), // 선택된 버튼 텍스트 색상
                        selectedBorderColor: Color(0xffC77749), // 선택된 버튼 테두리 색상

                        // renderBorder: false,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17),
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
                            padding: EdgeInsets.symmetric(horizontal: 17),
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

                  // 시간 상세 설정 카테고리
                  Container(
                    margin: EdgeInsets.only(right: 71),
                    width: 146,
                    height: 31,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xffC77749), // 박스 테두리 색상
                          width: 0.5 // 테두리 굵기
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      color: Color(0xffF5F5F5), // 박스 배경 색상
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, left: 13, right: 14),
                      child: Text(
                        '^ 13시      ^ 20분 까지',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          letterSpacing: 0.01,
                          color: Color(0xff252525),
                        ),
                      ),
                    ),
                  ),

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
                        child:  Text(
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
              // 도착지 입력 텍스트 필드 생성
              Container(
                margin: EdgeInsets.only(left: 22.0, right: 20.0, top: 6.0),
                width: 318,
                height: 31,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff2D2D2D),
                      width: 0.5 // 테두리 굵기
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Color(0xffF5F5F5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 7.5,left: 7.5, right: 7.5),
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
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              // 상세 주소 텍스트 필드
              Container(
                margin: EdgeInsets.only(left: 22.0, right: 20.0, top: 6.0),
                width: 318,
                height: 31,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff2D2D2D),
                      width: 0.5 // 테두리 굵기
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Color(0xffF5F5F5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 9.75,left: 8, right: 8),
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
                        child:  Text(
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
                        margin: EdgeInsets.only(left: 0, right: 29),
                        width: 104,
                        height: 31,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff2D2D2D),
                              width: 0.5 // 테두리 굵기
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          color: Color(0xffF5F5F5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8,left: 0, right: 10),
                          child: TextField(
                            controller: priceController,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.01,
                              color: Color(0xff111111),
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Image.asset('assets/images/₩.png'),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 119,
                      height: 31,
                      // 토글 버튼 만들기
                      margin: EdgeInsets.only(right: 85),
                      child: ToggleButtons(
                        color: Color(0xff2E2E2E), // 선택되지 않은 버튼 텍스트 색상
                        borderColor: Color(0xffF2F2F2), // 토글 버튼 테두리 색상
                        borderWidth: 0.5,
                        borderRadius: BorderRadius.circular(8.0),

                        selectedColor: Color(0xffC77749), // 선택된 버튼 텍스트 색상
                        selectedBorderColor: Color(0xffC77749), // 선택된 버튼 테두리 색상

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
                            padding: EdgeInsets.symmetric(horizontal: 11),
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



            ],
          ),
        ),
      ),
    );
  }
}