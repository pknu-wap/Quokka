import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'showerrandwidget/stamp/namelength/namelength2.dart';
import 'showerrandwidget/stamp/namelength/namelength3.dart';
import 'showerrandwidget/stamp/namelength/namelength4.dart';
import 'showerrandwidget/stamp/namelength/namelength5more.dart';
import 'showerrandwidget/tablescreen/tablescreen1.dart';
import 'showerrandwidget/tablescreen/tablescreen2.dart';

final storage = FlutterSecureStorage(); // 토큰 받기

// Errand 구조체
class ErrandName {
  String name; // 사용자 실명
  String nickName; // 사용자 닉네임
  ErrandName(
      this.name,
      this.nickName);

  factory ErrandName.fromJson(Map<String, dynamic> json) {
    return ErrandName(
      json['name'],
      json['nickname'],
    );
  }
}

// Error 구조체
class ErrorName {
  String code;
  var httpStatus;
  String message;

  ErrorName(this.code, this.httpStatus, this.message);

  factory ErrorName.fromJson(Map<String, dynamic> json) {
    return ErrorName(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}
class order {
  int orderNo;
  String nickname; // 닉네임
  double score; // 평점
  order(this.orderNo, this.nickname, this.score);

  factory order.fromJson(Map<String, dynamic> json) {
    return order(
      json['orderNo'],
      json['nickname'],
      json['score'],
    );
  }
}
class Errand {
  // 게시글에 담긴 정보들
  order o1;
  int errandNo; //게시글 번호
  String createdDate; //생성된 날짜
  String title; //게시글 제목
  String destination; //위치
  double latitude; // 위도
  double longitude; // 경도
  String due; // 일정 시간
  String detail; // 상세정보
  int reward; // 심부름 값
  bool isCash; // 계좌이체, 현금
  String status; //상태 (모집중 or 진행중 or 완료됨)
  bool isMyErrand; // 내 요청서인지 아닌지 확인
  Errand(
      this.o1,
      this.errandNo,
      this.createdDate,
      this.title,
      this.destination,
      this.latitude,
      this.longitude,
      this.due,
      this.detail,
      this.reward,
      this.isCash,
      this.status,
      this.isMyErrand);

  factory Errand.fromJson(Map<String, dynamic> json) {
    return Errand(
      order.fromJson(json['order']),
      json['errandNo'],
      json['createdDate'],
      json['title'],
      json['destination'],
      json['latitude'],
      json['longitude'],
      json['due'],
      json['detail'],
      json['reward'],
      json['isCash'],
      json['status'],
      json['isMyErrand'],
    );
  }
}
class Error {
  String code;
  var httpStatus;
  String message;

  Error(this.code, this.httpStatus, this.message);

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}
class Stamp extends StatelessWidget {
  final String realName;
  late String name1 = realName[0];
  late String name2 = realName[1];
  late String name3 = realName[2];
  late String name4 = realName[3];

  Stamp({
    required this.realName,
  });
  @override
  Widget build(BuildContext context) {
    // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
    return Stack(
      children: [
        // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장 틀
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                margin: EdgeInsets.only(top: 5.15, right: 32),
                child: Image.asset("assets/images/Rectangle3.png"))),
        if (realName.length == 2) // 심부름 하는 사람 이름 길이 2자
          NameLength2(name1: name1, name2: name2),
        if (realName.length == 3) // 심부름 하는 사람 이름 길이 3자
          NameLength3(
            name1: name1,
            name2: name2,
            name3: name3,
          ),
        if (realName.length == 4) // 심부름 하는 사람 이름 길이 4자
          NameLength4(
            name1: name1,
            name2: name2,
            name3: name3,
            name4: name4,
          ),
        if (realName.length == 1 || realName.length >= 5) // 심부름 하는 사람 이름 길이 1자 또는 5자 이상
          NameLength5More(),
      ],
    );
  }
}
class reShowErrandWidget extends StatelessWidget {
  final int errandNo;
  final String title;
  final String name;
  final String createdDate;
  final String due;
  final String destination;
  final String detail;
  final int reward;
  final String status;
  final bool isCash;
  final bool isCheckButtonVisible;
  final bool isStampVisible;
  final String nickName;
  final String realName;

  final EdgeInsets margin;

  reShowErrandWidget({
    required this.errandNo,
    required this.title,
    required this.name,
    required this.createdDate,
    required this.due,
    required this.destination,
    required this.detail,
    required this.reward,
    required this.status,
    required this.isCash,
    required this.isCheckButtonVisible,
    required this.isStampVisible,
    required this.nickName,
    required this.realName,
    required this.margin,
  });

  // 심부름 요청서 상세 페이지
  @override
  Widget build(BuildContext context) {
    String decodedrealname = utf8.decode(realName.runes.toList());
    String decodednickname = utf8.decode(nickName.runes.toList());
    return Container(
      width: 324, height: 576,
      decoration: BoxDecoration(
        color: Color(0xffFCFCF9),
      ),
      child: Column(
        children:[
          // 닫기 버튼
          GestureDetector(
            onTap: () { // 버튼 클릭 시 이전 페이지인 요청서 확인 페이지로 이동
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(left: 280, top: 8),
              color: Colors.transparent,
              child: Icon(
                Icons.close,
                color: Color(0xff8E8E8E),
              ),
            ),
          ),

          // 심부름 요청서 제목
          Container(
            margin: EdgeInsets.only(top: 4, left: 93, right: 91),
            child: Text(
              "심부름 요청서",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 0.00,
                color: Color(0xff000000),
              ),
            ),
          ),

          Container(
            width: 217,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "사랑하는 ",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      letterSpacing: 0.00,
                      color: Color(0xff111111),
                    ),
                  ),
                ),
                Container(
                  child: Container(
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
                                child: Container(
                                  margin: EdgeInsets.only(top: 0, left: 2,),
                                  child: Text(
                                    decodedrealname,
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
                            ]
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    " 님의 탁월함과 ",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      letterSpacing: 0.00,
                      color: Color(0xff111111),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 252,
            child : Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center, // 텍스트 가운데 정렬
                text: TextSpan(
                  text: "열정에 감사하며 아래와 같이 심부름을 요청합니다. 심부름 사항을 확인 후 완료 버튼을 통해 심부름을 확정해주시면 감사하겠습니다.",
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
          ),

          // -아래- 텍스트
          Container(
            margin: EdgeInsets.only(top: 11, left: 144, right: 151),
            child: Text(
              "-아래-",
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                fontSize: 11,
                letterSpacing: 0.00,
                color: Color(0xff000000),
              ),
            ),
          ),

          // 심부름 사항, 금액 및 결제
          Container(
            width: 287,
            height: 328.85,
            margin: EdgeInsets.only(top: 14),
            alignment: Alignment.center, // 중앙 정렬
            decoration: BoxDecoration(
              color: Color(0xffF1F1F1),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 13.65),
                    child: Row(
                      children: [
                        // 심부름 사항 네모 이미지
                        Container(
                            margin: EdgeInsets.only(left: 23.5),
                            child: Image.asset("assets/images/small_rectangle.png")
                        ),
                        //심부름 사항 텍스트
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "심부름 사항",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              letterSpacing: 0.001,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 6.68),
                  child: TableScreen1(
                    title: title,
                    name: name,
                    createdDate: createdDate,
                    due: due,
                    destination: destination,
                    detail: detail,
                  ),),

                // 금액 및 결제 텍스트
                Container(
                    margin: EdgeInsets.only(top: 7.68),
                    child: Row(
                      children: [
                        // 금액 및 결제 네모 이미지
                        Container(
                            margin: EdgeInsets.only(left: 23.5),
                            child: Image.asset("assets/images/small_rectangle.png")
                        ),
                        //금액 및 결제 텍스트
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "금액 및 결제",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              letterSpacing: 0.001,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    )),
                // 금액 및 결제 표
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: TableScreen2(
                    reward: reward,
                    isCash: isCash,
                  ),),
              ],
            ),
          ),
          // (주) 커카글쓴이 닉네임 (서명)
          Container(
            // margin: EdgeInsets.only(top: 17.15),
            child: Stack(
              children: [
                // (주) 커카글쓴이 -> 글 쓴 사람 -> name
                Align(
                  alignment: Alignment.centerLeft, // 왼쪽 정렬
                  child: Container(
                    margin: EdgeInsets.only(top: 17.15, left: 39.5),
                    child: Text(
                      "(주) ${utf8.decode(name.runes.toList())}",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        letterSpacing: 0.001,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft, // 가운데 정렬
                  child: Container(
                        margin: EdgeInsets.only(top: 17, left: 130),
                        child: Text(decodednickname,
                          style: TextStyle(
                            fontFamily: 'MaruBuri',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.01,
                            color: Color(0xff000000),
                          ),
                        ),
                  ),
                ),



                // Right-aligned (서명)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 17.15, right: 37),
                    child: Text(
                      "( 서 명 )",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        letterSpacing: 0.001,
                        color: Color(0xffA4A4A4),
                      ),
                    ),
                  ),
                ),
                // Line1.png
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.only(top: 41.15, right: 37.5),
                      child: Image.asset("assets/images/Line1.png")
                  ),
                ),
                if(isStampVisible)
                // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장
                  Stamp(
                    realName: utf8.decode(realName.runes.toList()),
                  ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
class ReShowErrand extends StatefulWidget {
  final String errandNo;
  // final Map<String, dynamic> ErrandName;

  ReShowErrand({
    Key? key,
    required this.errandNo,
    // required this.ErrandName,
  }) : super(key: key);

  @override
  State createState() => _ReShowErrandState();
}

class _ReShowErrandState extends State<ReShowErrand> {
  late String errandNo;
  late String title;
  late String name;
  late String createdDate;
  late String due;
  late String destination;
  late String detail;
  late int reward;
  late String status;
  late bool isCash;
  String? token = "";

  late String realName;
  late String nickName;

  Future<void> errandReading(String id) async {
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/$id";
    print(url + param);

    token = await storage.read(key: 'TOKEN');
    var response = await http
        .get(Uri.parse(url + param), headers: {"Authorization": "$token"});

    if (response.statusCode == 200) {
      Errand errand = Errand.fromJson(jsonDecode(response.body));
        title = errand.title;
        name = errand.o1.nickname;
        createdDate = errand.createdDate;
        due = errand.due;
        destination = errand.destination;
        detail = errand.detail;
        reward = errand.reward;
        status = errand.status;
        isCash = errand.isCash;
      log("status code == 200, Json Data Parsed.");
      setState(() {

      });
    } else {
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      print(error.code);
      print(error.httpStatus);
      print(error.message);
    }
  }
  Future<void> getErrandInfo(int id) async {
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/errander/$id";
    print(url + param);

    token = await storage.read(key: 'TOKEN');
    var response = await http
        .get(Uri.parse(url + param), headers: {"Authorization": "$token"});

    if (response.statusCode == 200) {
      ErrandName errandName = ErrandName.fromJson(jsonDecode(response.body));
      setState(() {
        realName = errandName.name; // DB에 저장된 사용자 실명
        nickName = errandName.nickName; // DB에 저장된 사용자 닉네임
      });
      log("status code == 200, Json Data Parsed.");
    } else {
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      ErrorName error = ErrorName.fromJson(json);
      print(error.code);
      print(error.httpStatus);
      print(error.message);
    }
  }

  // 확인했어요. 버튼 변수'

  @override
  void initState() {
    super.initState();
    errandNo = widget.errandNo;
    nickName = "닉 네 임"; // 심부름 하는 사람 닉네임
    realName = ""; // 심부름 하는 사람 실제 이름
    errandReading(errandNo);
    getErrandInfo(int.parse(errandNo));
  }
  // 메인 글 보기 화면
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Color(0xffF6F6F6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 게시글 중앙 정렬
                  children: [
                    Container(
                      // 심부름 요청서 상세 부분
                      child: Flexible(
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: 324,
                            height: 576,
                            margin: EdgeInsets.only(top: 75, left: 18.5), // 기존 마진 -> 확정 마진
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Color(0xffFCFCF9),
                              boxShadow: [
                                BoxShadow( // 5px 5px 10px rgba(0, 0, 0, 0.25);
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(5, 5), // 그림자의 위치
                                  blurRadius: 10, // 그림자의 흐림 정도
                                  spreadRadius: 0, // 그림자의 확산 정도
                                ),
                              ],
                            ),
                            child: reShowErrandWidget(
                              errandNo: int.parse(errandNo),
                              title: title,
                              name: name,
                              createdDate: createdDate,
                              due: due,
                              destination: destination,
                              detail: detail,
                              reward: reward,
                              status: status,
                              isCash: isCash,
                              isCheckButtonVisible: false,
                              isStampVisible: true,
                              nickName : nickName,
                              realName : realName,
                              margin : EdgeInsets.only(top: 75, left: 18.5),
                            ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}