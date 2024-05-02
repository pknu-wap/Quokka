import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  TextEditingController titleController =
  TextEditingController();
  TextEditingController destinationController =
  TextEditingController();
  TextEditingController priceController =
  TextEditingController();

  bool isTitleEnabled = false;
  bool isDestinationEnabled = false;
  bool isPriceEnabled = false;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Padding(
      padding: EdgeInsets.only(left: 10.0, top: 33.0), // 아이콘과 텍스트의 여백을 설정합니다.
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 0), // 아이콘과 텍스트 사이의 간격을 설정합니다.
          Text(
            '요청서 작성하기',
            style: TextStyle(
              color: Color(0xFF111111),
              fontFamily: 'Paybooc',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
              Container(
                // padding: EdgeInsets.all(40.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 34),
                        // // 전체 마진
                        // width: 35,
                        // // 25 + 3 + 7 = 35
                        // height: 17,
                        // // 텍스트 필드의 높이 설정
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Expanded(
                            //   child:
                              Container(
                                margin: EdgeInsets.only(top: 34,left: 15),
                                // 일정 텍스트
                                child: Text(
                                  '제목',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            // ),

                            Container(
                              margin: EdgeInsets.only(top: 34,left: 5),
                              // 일정 텍스트
                              child: Text(
                                '*',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),),

                      Container(
                        margin: EdgeInsets.only(left: 22.0, right: 20.0, top: 5.0),
                        width: 318,
                        height: 31,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFF2D2D2D),
                              width: 0.5 // 테두리 굵기
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 7.5),
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
                            )),
                      ),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  // 전체 마진
                  width: 216,
                  // 25 + 14 + 177 = 216
                  height: 25,
                  // 텍스트 필드의 높이 설정
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          // 일정 텍스트
                          child: Text(
                            '일정',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 1),
                        // 일정 텍스트
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 121),
                        child: Text(
                          '예약은 최대 ?시간 이후까지 가능해요.',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  // 전체 마진
                  width: 216,
                  // 25 + 14 + 177 = 216
                  height: 25,
                  // 텍스트 필드의 높이 설정
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          // 일정 텍스트
                          child: Text(
                            '즉시 예약',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 121),
                        child: Text(
                          '13시 20분까지',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 24),
                  // 전체 마진
                  width: 216,
                  // 37 + 3 = 40
                  height: 25,
                  // 텍스트 필드의 높이 설정
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 3),
                          // 일정 텍스트
                          child: Text(
                            '도착지',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 289),
                        // 일정 텍스트
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),











                      // Container(
                      //   margin: EdgeInsets.only(left: 22, top: 4),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       '영문 대문자, 소문자, 숫자, 특수문자를 포함하여 8~20자로 입력해주세요.',
                      //       style: TextStyle(
                      //         color: Color(0xFF9E9E9E),
                      //         fontFamily: 'Pretendard',
                      //         fontWeight: FontWeight.w400,
                      //         letterSpacing: 0.01,
                      //         fontSize: 11,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      // Container(
                      //   margin: EdgeInsets.only(top: 8),
                      //   width: 320,
                      //   height: 38,
                      //   // 텍스트 필드의 높이 설정
                      //   /*child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 0),*/
                      //   // 가로 패딩 추가
                      //   child: TextField(
                      //     maxLength: maxPasswordLength,
                      //     // 최대 길이 설정
                      //     onChanged: (text) {
                      //       checkPasswordAvailable(); //체크해서 비밀번호 텍스트 필드 아래에 메시지 출력
                      //
                      //       if (text.length < minPasswordLength) {
                      //         print('최소 $minPasswordLength자 이상 입력해주세요.');
                      //       } else if (text.length > maxPasswordLength) {
                      //         print('최대 $maxPasswordLength자만 입력할 수 있습니다.');
                      //       }
                      //     },
                      //     controller: passwordController,
                      //     obscureText: !isPasswordButtonVisible,
                      //     // 비밀번호 가리기/보이기 설정
                      //     decoration: InputDecoration(
                      //       errorText: null,
                      //       // 초기에 오류 메시지 표시x
                      //       hintStyle: TextStyle(fontSize: 10),
                      //       filled: true,
                      //       fillColor: passwordFilledColor,
                      //       labelStyle: TextStyle(
                      //           color: passwordFontColor,
                      //           fontFamily: 'Pretendard',
                      //           fontWeight: FontWeight.w400),
                      //       contentPadding: EdgeInsets.only(left: 11.58),
                      //       // 텍스트를 수직으로 가운데 정렬
                      //       border: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0)),
                      //         borderSide: BorderSide(
                      //             color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                      //         ),
                      //       ),                              // 밑줄 없애기
                      //       // 밑줄 없애기
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0)),
                      //         borderSide: BorderSide(
                      //             color: passwordBorderColor, width: 0.5 // 테두리 굵기
                      //         ),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0)),
                      //         borderSide: BorderSide(
                      //             color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                      //         ),
                      //       ),
                      //       suffixIcon: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             isPasswordButtonVisible = !isPasswordButtonVisible; // 상태를 반전시켜서 눈모양 버튼을 클릭할 때마다 비밀번호 보이기/가리기 토글
                      //           });
                      //         },
                      //         icon: isPasswordButtonVisible
                      //             ? Image.asset('assets/images/open eye.png')
                      //             : Image.asset(
                      //             'assets/images/close eye.png'), // 이미지 아이콘 설정
                      //       ),
                      //       counterText:
                      //       '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                      //     ),
                      //     keyboardType: TextInputType.text,
                      //     enabled: nicknameText == "중복 확인이 완료되었습니다.",
                      //   ),
                      // ),
                      //
                      // Container(
                      //   margin: EdgeInsets.only(left: 22, top: 7),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       passwordText,
                      //       style: TextStyle(
                      //           fontSize: 12,
                      //           fontFamily: 'Pretendard',
                      //           fontWeight: FontWeight.w400,
                      //           color: passwordTextColor
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 24, top: 4),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       "비밀번호 확인",
                      //       style: TextStyle(
                      //         color: Color(0xFF373737),
                      //         fontFamily: 'Pretendard',
                      //         fontWeight: FontWeight.w700,
                      //         fontSize: 14,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      // Container(
                      //   margin: EdgeInsets.only(top: 9),
                      //   width: 320,
                      //   height: 38,
                      //   // 가로 패딩 추가
                      //   child: TextField(
                      //     maxLength: maxPasswordCheckLength,
                      //     // 최대 길이 설정
                      //     onChanged: (text) {
                      //       CheckPassword();
                      //
                      //       if (text.length < minPasswordCheckLength) {
                      //         print('최소 $minPasswordCheckLength자 이상 입력해주세요.');
                      //       } else if (text.length > maxPasswordCheckLength) {
                      //         print('최대 $maxPasswordCheckLength자만 입력할 수 있습니다.');
                      //       }
                      //     },
                      //     controller: passwordCheckController,
                      //     obscureText: !isPasswordCheckButtonVisible,
                      //     // 비밀번호 확인 가리기/보이기 설정
                      //
                      //     decoration: InputDecoration(
                      //       hintStyle: TextStyle(fontSize: 10),
                      //       filled: true,
                      //       fillColor: passwordCheckFilledColor,
                      //       labelStyle: TextStyle(
                      //           color: passwordCheckFontColor,
                      //           fontFamily: 'Pretendard',
                      //           fontWeight: FontWeight.w400),
                      //       contentPadding: EdgeInsets.only(left: 11.58),
                      //       // 텍스트를 수직으로 가운데 정렬
                      //       // 밑줄 없애기
                      //       border: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0)),
                      //         borderSide: BorderSide(
                      //             color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                      //         ),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0)),
                      //         borderSide: BorderSide(
                      //             color: passwordCheckBorderColor, width: 0.5 // 테두리 굵기
                      //         ),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0)),
                      //         borderSide: BorderSide(
                      //             color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                      //         ),
                      //       ),
                      //       suffixIcon: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             isPasswordCheckButtonVisible =
                      //             !isPasswordCheckButtonVisible; // 상태를 반전시켜서 눈모양 버튼을 클릭할 때마다 비밀번호 보이기/가리기 토글
                      //           });
                      //         },
                      //         icon: isPasswordCheckButtonVisible
                      //             ? Image.asset('assets/images/open eye.png')
                      //             : Image.asset(
                      //             'assets/images/close eye.png'), // 이미지 아이콘 설정
                      //       ),
                      //       counterText:
                      //       '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                      //     ),
                      //     keyboardType: TextInputType.text,
                      //     enabled: passwordText == "",
                      //   ),
                      // ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                      //
                      // Container(
                      //   margin: EdgeInsets.only(left: 24, top: 7),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       passwordCheckText,
                      //       style: TextStyle(
                      //         color: passwordCheckTextColor,
                      //         fontFamily: 'Pretendard',
                      //         fontWeight: FontWeight.w700,
                      //         fontSize: 12,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      // Container(
                      //     margin: EdgeInsets.only(top: 12),
                      //     width: 320,
                      //     height: 40,
                      //     child: ElevatedButton(
                      //       onPressed: passwordCheckText == ""
                      //           ? () {
                      //         // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                      //         print('doubleCheck Button Clicked!');
                      //
                      //         if (DuplicateFlag){
                      //           joinRequest(u1);
                      //           print("Join");
                      //         } else {
                      //           setState(() {
                      //             nicknameText = "중복 확인 버튼을 눌러주세요.";
                      //             nicknameTextColor = Color(0xFFE33939);
                      //           });
                      //         }
                      //       }
                      //           : null,
                      //       style: ButtonStyle(
                      //         // 버튼의 배경색 변경하기
                      //         backgroundColor: passwordCheckText == ""
                      //             ? MaterialStateProperty.all<Color>(
                      //             Color(0xFF7C3D1A))
                      //             : MaterialStateProperty.all<Color>(
                      //             Color(0xFFBD9E8C)),
                      //         minimumSize: MaterialStateProperty.all<Size>(
                      //             Size(320, 40)),
                      //         // 버튼의 모양 변경하기
                      //         shape: MaterialStateProperty.all<
                      //             RoundedRectangleBorder>(
                      //           RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(
                      //                 10), // 원하는 모양에 따라 BorderRadius 조절
                      //           ),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         '완료',
                      //         style: TextStyle(
                      //           fontSize: 13,
                      //           fontFamily: 'Pretendard',
                      //           fontWeight: FontWeight.w600,
                      //           color: Color(0xFFFFFFFF),
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}