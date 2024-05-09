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
  TextEditingController titleController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController priceController = TextEditingController();

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
                        color: Color(0xff111111),
                        fontFamily: 'Paybooc',
                        fontWeight: FontWeight.w700,
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
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
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
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF05252),
                        ),
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