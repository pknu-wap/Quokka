import 'dart:convert';
import 'dart:developer';
import 'package:front/main/writeerrand/checkerrand.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/main/home/home.dart';
import 'package:front/mainshowerrand/showerrandwidget/showerrandwidget.dart';
import 'package:front/main/writeerrand/writeerrand.dart';

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

class MainShowErrand extends StatefulWidget {
  final Map<String, dynamic> errands;
  // final Map<String, dynamic> ErrandName;

  MainShowErrand({
    Key? key,
    required this.errands,
    // required this.ErrandName,
  }) : super(key: key);

  @override
  State createState() => _MainShowErrandState();
}

class _MainShowErrandState extends State<MainShowErrand> {
  late int errandNo;
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

  Future<void> getErrandName(int id) async {
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/$id/accept";
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
  bool isCheckButtonVisible = true;
  bool isStampVisible = false;
  EdgeInsets errandConfirmedMargin = EdgeInsets.only(top: 40, left: 18.5);


  @override
  void initState() {
    super.initState();
    print(widget.errands);
    errandNo = widget.errands["errandNo"];
    title = widget.errands["title"];
    name = widget.errands["nickname"];
    createdDate = widget.errands["createdDate"];
    due = widget.errands["due"];
    destination = widget.errands["destination"];
    detail = widget.errands["detail"];
    reward = widget.errands["reward"];
    status = widget.errands["status"];
    isCash = widget.errands["isCash"];
    nickName = "닉 네 임"; // 심부름 하는 사람 닉네임
    realName = "   "; // 심부름 하는 사람 실제 이름

  }
  // 메인 글 보기 화면
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                              child: Container(
                                width: 324,
                                height: 576,
                                margin: errandConfirmedMargin, // 기존 마진 -> 확정 마진
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
                                child: ShowErrandWidget(
                                        errandNo: errandNo,
                                        title: title,
                                        name: name,
                                        createdDate: createdDate,
                                        due: due,
                                        destination: destination,
                                        detail: detail,
                                        reward: reward,
                                        status: status,
                                        isCash: isCash,
                                        isCheckButtonVisible: isCheckButtonVisible,
                                        isStampVisible: isStampVisible,
                                        nickName : nickName,
                                        realName : realName,
                                      )
                        ),
                      ),
                      ),

                    // 확인했어요. 버튼
                    if(isCheckButtonVisible) // 버튼이 보이면,
                    Container(
                      margin: EdgeInsets.only(left: 20.5, right: 21.5, top: 11),
                      child: ElevatedButton(
                        onPressed: () {
                          print("확인했어요. 클릭");
                          // 확인했어요. 버튼 사라지게 만들고, 심부름 요청서 마진 조정,
                          // 사용자 닉네임 받아와 텍스트 필드에 채워넣고, 도장 찍기
                          setState(() {
                            isCheckButtonVisible = false;
                            isStampVisible = true;
                            errandConfirmedMargin = EdgeInsets.only(top: 75, left: 18.5); // 심부름 요청서 마진 변경
                            getErrandName(errandNo);// 심부름 하는 사람 닉네임  -> 연동 부분, 심부름 하는 사람 실명 -> 연동 부분
                            status = "PROCEEDING"; // 심부름 상태 진행중으로 변경
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF7C3D1A)),
                          // 버튼의 크기 정하기
                          minimumSize:
                          MaterialStateProperty.all<Size>(Size(318, 46.65)),
                          // 버튼의 모양 변경하기
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // 원하는 모양에 따라 BorderRadius 조절
                            ),
                          ),
                        ),
                        child: Text(
                          '확인했어요.',
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
                )),

          ],
        ),
      ),
    );
  }
}
