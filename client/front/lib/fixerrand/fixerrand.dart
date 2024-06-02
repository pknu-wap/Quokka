import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../checkerrand.dart';
import '../writeerrand.dart';
import 'fixerrandwidget/fixdue.dart';
import 'fixerrandwidget/fixiscash.dart';
import 'fixerrandwidget/fixminimap.dart';
import 'package:http/http.dart' as http;
final storage = FlutterSecureStorage();


class FixErrand extends StatefulWidget {
  final Map<String, dynamic> errands;

  FixErrand({
    Key? key,
    required this.errands,
  }) : super(key: key);

  @override
  State createState() => _FixErrandState();
}

class _FixErrandState extends State<FixErrand> {
  late ErrandRequest errand;

  void errandUpdateRequest() async {
    errand = ErrandRequest(
        createdDate: widget.errands['createdDate'],
        title: titleController.text,
        destination: detailAddressController.text,
        latitude: latitude,
        longitude: longitude,
        due: setDue(),
        detail: requestController.text,
        reward: int.parse(priceController.text),
        isCash: isSelected2[1],
    );
    print("print errands");
    print(errand);
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/${errandNo}";
    String? token = await storage.read(key: 'TOKEN');
    try {
      var response = await http.put(Uri.parse(url+param),
          body: jsonEncode(errand.toJson()),
          headers: {"Authorization": "$token",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MainErrandCheck(errandNo: errandNo,)
          ),);
      }
      else {
        print("ERROR : ");
        print(jsonDecode(response.body));
      }
    } catch(e) {
      print(e.toString());
    }
  }
  String setDue() {
    DateTime now = DateTime.now();
    if(isSelected1[1]) // 내일 선택
      now = now.add(Duration(days : 1)); // 다음 날이므로, 1일 추가
    DateTime due = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedHour,
        _selectedMinute
    );
    return due.toString();
  }
  setDayAtChildWidget(List<bool> list) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isSelected1 = list;
      });
    });
  }
  setHourAtChildWidget(int hour) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedHour = hour;
      });
    });
  }
  setMinuteAtChildWidget(int minute) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedMinute = minute;
      });
    });
  }
  setIsCashAtChildWidget(List<bool> list) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isSelected2 = list;
      });
    });
  }
  setLatLongAtChildWidget(double lat, double long) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        latitude = lat;
        longitude = long;
      });
    });
  }

  late List<bool> isSelected1 = [true, false]; // 일정 오늘/내일
  late int _selectedHour; // 선택된 시간 저장
  late int _selectedMinute; // 선택된 분 저장

  late List<bool> isSelected2 = [true, false]; // 현금/계좌이체

  late int errandNo;
  late String title;
  late String name;
  late String createdDate;
  late String due;
  late String destination;
  late double latitude;
  late double longitude;
  late String detail;
  late int reward;
  late String status;
  late bool isCash;

  final int maxTitleLength = 20; // 제목 최대 길이 설정

  TextEditingController titleController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  // 텍스트 필드 변수 선언
  bool isTitleEnabled = true;
  bool isDetailAddressEnabled = true;
  bool isPriceEnabled = true;
  bool isRequestEnabled = true;

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    String decodedTitle = utf8.decode(widget.errands['title'].runes.toList());
    String decodedDetailAddress = utf8.decode(widget.errands['destination'].runes.toList());
    String decodedRequest = utf8.decode(widget.errands['detail'].runes.toList());
    titleController = TextEditingController(text: decodedTitle);
    detailAddressController = TextEditingController(text:decodedDetailAddress);
    priceController = TextEditingController(text: widget.errands['reward'].toString());
    requestController = TextEditingController(text: decodedRequest);

    titleController.addListener(updateTitleState);
    detailAddressController.addListener(updateDestinationState);
    priceController.addListener(updatePriceState);
    requestController.addListener(updateRequestState);

    latitude = widget.errands['latitude'];
    longitude = widget.errands['longitude'];
    due = widget.errands['due'];
    createdDate = widget.errands['createdDate'];
    isCash = widget.errands['isCash'];

    errandNo = widget.errands['errandNo'];

  }

    @override
    void dispose() {
      // 위젯이 제거될 때 호출됨
      titleController.dispose();
      detailAddressController.dispose();
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
        isDetailAddressEnabled = detailAddressController.text.isNotEmpty;
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
                        '수정하기',
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
                  margin: EdgeInsets.only(top: 10),
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
                //제목 텍스트 필드
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0),
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
                    padding: EdgeInsets.only(bottom: 2, left: 10, right: 10),
                    child: TextField(
                      maxLength: maxTitleLength,
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
                        counterText: '',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),

                // 일정 텍스트
                Container(
                  margin: EdgeInsets.only(top: 14),
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
                // 일정
                FixDue(due: due,
                  setDayParentState: setDayAtChildWidget,
                  setHourParentState: setHourAtChildWidget,
                    setMinuteParentState: setMinuteAtChildWidget),
                // 도착지 텍스트
                Container(
                  margin: EdgeInsets.only(top: 18),
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
                // 네이버 미니 지도
                FixMiniMap(latitude: latitude, longitude: longitude, setLatLongParentStatue: setLatLongAtChildWidget,),
                // 상세 주소 텍스트 필드
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 7.0),
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
                  margin: EdgeInsets.only(top: 18),
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
                  margin: EdgeInsets.only(top: 6, left: 20.0),
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
                                  border: Border.all(
                                      color: Color(0xff2D2D2D),
                                      width: 0.5 // 테두리 굵기
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  color: Color(0xffFFFFFF),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 1, left: 27, right: 7.5),
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
                                    keyboardType: TextInputType.number,
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
                      // 결제 방법
                      FixIsCash(isCash: isCash, setIsCashParentState: setIsCashAtChildWidget,),
                    ],
                  ),
                ),

                // 요청사항 텍스트
                Container(
                  margin: EdgeInsets.only(top: 18),
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
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0),
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
                // 수정 완료 버튼 만들기
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 18),
                  child: ElevatedButton(
                    onPressed: () {
                      errandUpdateRequest();
                    },
                    style: ButtonStyle(
                      // 버튼의 배경색 변경하기
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (isTitleEnabled &&
                                isDetailAddressEnabled &&
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
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(318, 41)),
                      // 버튼의 모양 변경하기
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // 원하는 모양에 따라 BorderRadius 조절
                        ),
                      ),
                    ),
                    child: Text(
                      '수정 완료',
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