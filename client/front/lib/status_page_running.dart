import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_dialog.dart';
import 'home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 're-showmap.dart';
import 'showerrand/re-showerrand.dart';
final storage = FlutterSecureStorage();
class StatusContent{//진행중인 심부름이 간략하게 담고 있는 정보들
  String contents; //메시지
  String created; //메시지 생성 시간
  StatusContent(this.contents, this.created);
  factory StatusContent.fromJson(Map<String, dynamic> json) {
    return StatusContent(
      utf8.decode(json['contents'].runes.toList()),
      utf8.decode(json['created'].runes.toList()),
    );
  }
}

//
class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  scoreOther(_rating) async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}score";
    int connectNoInt = int.parse(connectNo);
    double score = _rating.toDouble();
    String param = "?errandNo=$connectNoInt&score=$score";
    String? token = await storage.read(key: 'TOKEN');
    var response = await http.put(Uri.parse(url + param),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      scoreCompleteDialog(context);
    }
    else {
      print(response.body);
    }
  }

  // 평가 완료 감사 팝업
  void scoreCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (didPop) {
                return;
              }
            },
        child : Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              // padding: EdgeInsets.all(20),
              width: 323,
              height: 214,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Icon(
                      Icons.sentiment_satisfied_alt,
                      size: 40,
                      color: Color(0xffA98474),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      "평가해주셔서 감사합니다!",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.00,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1, 47.25)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // 원하는 모양에 따라 BorderRadius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "메인으로 이동하기",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.00,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        );
      },
    );
  }
  // 평가 나가기 팝업
  void scoreConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return  Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              // padding: EdgeInsets.all(20),
              width: 323,
              height: 275.75,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.04),
                    child: Image.asset(
                      'assets/images/alert.png',
                      width: 76.83,
                      height: 76.83,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.08),
                    child: Text(
                      "지금 나가면 평가할 수 없어요!",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.00,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17.77),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1, 47.25)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // 원하는 모양에 따라 BorderRadius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "평가하러 가기",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.00,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17.77),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFFFFFFF)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1, 47.25)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: Color(0xff999999), // 테두리 색상
                                width: 1 // 테두리 두께
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "나가기",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 0.00,
                          color: Color(0xff3E3E3E),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 평가하기 팝업
  int _rating = 0;
  final List<String> ratingTexts = [
    '',
    '최악이에요;;',
    '별로에요...ㅜ',
    '그럭저럭 괜찮아요~',
    '좋았어요~!',
    '최고에요!!'
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
      if (didPop) {
        return;
      }
    },
      child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Color(0xffB6B6B6), width: 1),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 323,
          height: 343,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container( margin: EdgeInsets.only(top: 19, left: 22),
                      child: Text(
                        '평가하기',
                        style: TextStyle(fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 0.00,
                          color: Color(0xff616161),),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 177), //원래 197인데 잘려서 줄여놓음
                      child: IconButton(
                        icon: Icon(
                            Icons.close,
                        color: Color(0xff8D8D8D),
                        size: 35,),
                        onPressed: () {
                          scoreConfirmDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 19, left: 22, right: 50),
                child:  Text(
                  '더 나은 거래를 위해 오늘의 거래를 평가해주세요!',
                  style: TextStyle(fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    letterSpacing: 0.00,
                    color: Color(0xff404040),),),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 0, right: 50),
                  child:  Text('상대방 평가 후 나의 평가를 확인할 수 있어요.',
                    style: TextStyle(fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.00,
                      color: Color(0xff404040),),),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 18.71, left: 27, right: 31),
                  child: Container(
                      width: 265,
                      child: Divider(
                          color: Color(0xffBCBCBC),
                          thickness: 0.5))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Image.asset(
                      index < _rating
                          ? 'assets/images/quokka_pointO.png'
                          : 'assets/images/quokka_pointX.png',
                      width: 39.57,
                      height: 39.99,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
              child: Text(ratingTexts[_rating],
                style: TextStyle(fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 0.00,
                  color: Color(0xff1A1A1A),),),),
              Visibility(
              visible: _rating > 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                  '($_rating / 5) 점',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    letterSpacing: 0.00,
                    color: Color(0xff1A1A1A),
                  ),
                ),
              ),
              ),
              Container(
                margin: EdgeInsets.only(top: 18, left: 11.5, right: 11.5),
                child: ElevatedButton(
                  onPressed: _rating == 0 ? (){}
                      : () {
                    scoreOther(_rating);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7C3D1A),
                    fixedSize: Size(318, 45), // 너비와 높이
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // 테두리 둥글기 설정 (0은 둥글지 않음)
                    ),
                  ),
                  child: Container(
                    width: 300,
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      '평가 완료했어요',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.01,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    )
    );
  }
}
String extractTime(String timeData) {
  // DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(timeData);

  // 시간과 분 추출
  String hours = dateTime.hour.toString().padLeft(2, '0');
  String minutes = dateTime.minute.toString().padLeft(2, '0');

  return '$hours:$minutes';
}
class Status_Content_Widget extends StatelessWidget {
  final String contents; // 메시지
  final String created; // 메시지 생성 시간
  final controller;
  final animation;

  const Status_Content_Widget({
    Key? key,
    required this.controller,
    required this.animation,
    required this.contents,
    required this.created,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: animation,
        builder:(context, child)
    {
      return Opacity(opacity: animation.value,
          child: Container(
            width: 320,
            height: 70, // 메시지 1개
            margin: EdgeInsets.only(top: 21.87),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 247.18,
                  height: 42.79,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(-1, 1),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Image.asset(
                        contents == "완료했어요!"
                            ? 'assets/images/진한말풍선R.png'
                            : 'assets/images/연한말풍선R.png',
                        width: 247.18,
                        height: 42.79,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            contents,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.01,
                              fontSize: 15,
                              color: contents == "완료했어요!"
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff232323),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 35.43,
                        height: 35.43,
                        margin: EdgeInsets.only(top: 8.28, left: 7.04),
                        child: Image.asset(
                          contents == "완료했어요!"
                              ? 'assets/images/smiley Quokka.png'
                              : 'assets/images/Quokka.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.91, top: 5.3),
                        child: Text(
                          extractTime(created),
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.01,
                            fontSize: 14,
                            color: Color(0xff747474),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
      );
    }
    );
  }
}
DropdownMenuItem<String> customDropdownItem(String text) {
  return DropdownMenuItem<String>(
    value: text,
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffDCDCDC), width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.01,
          color: Color(0xff232323),
        ),
      ),
    ),
  );
}
class statuspageR extends StatefulWidget {
  final int errandNo;
  const statuspageR({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  State<statuspageR> createState() => _statuspageRState();
}


String connectNo = "";
late StompClient stompClient;

void setComplete() {
  stompClient.send(
    destination: '/app/$connectNo', // 전송할 destination
    body: json.encode({
      "contents": "완료했어요!",
      }), // 메시지의 내용
  );
}

class _statuspageRState extends State<statuspageR> with TickerProviderStateMixin{

  void onConnect(StompClient stompClient,StompFrame frame) {
    stompClient.subscribe(
      destination: '/queue/$connectNo',
      callback: (frame) {
        setState(() {
          contents.add(json.decode(frame.body!));
          addItemAnimation();
          scrollToBottom();
        });
        /**
         *  이 부분에
         *  result를 표시 list에 추가하는 코드
         */
      },
    );
  }
  void addItemAnimation() {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    controllers.add(controller);
    animations.add(animation);

    controller.forward();
  }


  late int errandNo;
  List<Map<String, dynamic>> contents = [];
  List<AnimationController> controllers = [];
  List<Animation<double>> animations = [];
  bool isCompleted = false;
  ScrollController _scrollController = ScrollController();
  void completeCheck()
  {
    if(contents.isNotEmpty && contents.last['contents'] == '완료했어요!')
      isCompleted = true;
    else
      isCompleted = false;
    return;
  }
  statusMessageInit() async{
   //errandNo = widget.errandNo;
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}statusMessage/$errandNo";
    String? token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    print(url);
    if(response.statusCode == 200) {
      print('contents add 200');
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        StatusContent c1 = StatusContent.fromJson(item);
        addItemAnimation();
        contents.add({
          "contents": c1.contents,
          "created": c1.created,
        });
      }
      setState(() {});
    }
    else {
      print("비정상 요청");
    }
  }

  sendValue(String? value) {
    if (value != null && value.isNotEmpty) {
      print(value);
      stompClient.send(
        destination: '/app/$connectNo', // 전송할 destination
        body: json.encode({
          "contents": value,
        }), // 메시지의 내용
      );
    }
  }
  errander_complete() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}$connectNo/complete/errander";
    String? token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      stompClient.deactivate();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return RatingDialog();
        },
      );
    }
    else {
      print("Errander가 완료처리하지 않았음");
      print("사용자가 errander가 아님");
    }
  }

  // 심부름 완료
  void confirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: 323,
              height: 268.29,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 35.87),
                    child: Image.asset(
                      'assets/images/check.png',
                      width: 39.08,
                      height: 28.95,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 36),
                    child: Text(
                      "심부름을 완료하시겠어요?",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.04,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Text(
                      "꼭 심부름이 완료되었을 때 눌러주세요.",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xff9B7D68),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 39.61),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFFFFFFF)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18, 45)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Color(0xff999999), // 테두리 색상
                                      width: 1 // 테두리 두께
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              "취소",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 0.00,
                                color: Color(0xff3E3E3E),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff7C3D1A)),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18, 45)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: Text(
                              "네, 완료하기",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 0.00,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            onPressed: () {
                              setComplete();
                              errander_complete();
                            },
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
      },
    );
  }
  void scrollToBottom() {
    if (contents.length > 5) {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final offset = 50; // 더 아래로 스크롤하고 싶은 거리

      _scrollController.animateTo(
        maxScrollExtent + offset,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }
  @override
  void initState()
  {
    super.initState();
    errandNo = widget.errandNo;
    connectNo = errandNo.toString();
    statusMessageInit();
    completeCheck();
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/ws',
        onConnect: (frame) => onConnect(stompClient, frame),
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );
    stompClient.activate();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xffF6F6F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 86, left: 26),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Image.asset(
                          'assets/images/arrow back.png',
                          color: Color(0xff6B6B6B),
                        ),
                      ),
                    ),
                    Container( height: 25,
                      margin: EdgeInsets.only(top: 80, left: 12),
                      child: Text(
                        '현황 페이지',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'paybooc',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.01,
                          color: Color(0xff111111),
                        ),
                      ),
                    ),
                    Container(
                      width: 19.02,
                      height: 26.15,
                      margin: EdgeInsets.only(top: 73.65, left: 139.98),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReShowMap(errandNo: connectNo)));
                        },
                        icon: Image.asset(
                          'assets/images/map.png',
                          color: Color(0xffB4B5BE),
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 25.81,
                      margin: EdgeInsets.only(top: 74, left: 13),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReShowErrand(errandNo: connectNo)));
                        },
                        icon: Image.asset(
                          'assets/images/errand.png',
                          color: Color(0xffB4B5BE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(child: Container(width: 320, height: 422,
                margin: EdgeInsets.only(left: 20, top: 21.21),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  //color: Colors.blue,
                  border: Border(
                    top: BorderSide(color: Colors.transparent, width: 1,),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 0.1, bottom: 45),
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: contents.length,
                    itemBuilder: (BuildContext context, int index){
                      return Status_Content_Widget(
                        controller: controllers[index],
                        animation: animations[index],
                        contents: contents[index]["contents"],
                        created: contents[index]["created"],
                      );
                    }
                ),
              ),),
              Column(
                children: [
                  Container(
                    width: 320,
                    height: 55.54,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffEDEDED),
                      border: Border(
                        top: BorderSide(color: Colors.transparent, width: 1,),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 284.99,
                        height: 31.53,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xffBDBDBD),
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            hint: Row(
                              children: [
                                Container( 
                                  child:  Image.asset(
                                    'assets/images/paper-plane.png',
                                    color: Color(0xffADADAD),
                                  ),
                                ),
                                SizedBox(width: 4.59), // Adjust the space between icon and text
                                Text(
                                  '메시지 보내기',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.01,
                                    color: Color(0xff656565),
                                  ),
                                ),
                              ],
                            ),
                            items: [
                              customDropdownItem("출발했어요."),
                              customDropdownItem("지금 물건을 픽업했어요."),
                              customDropdownItem("5분 뒤 도착해요."),
                              customDropdownItem("10분 뒤 도착해요."),
                              customDropdownItem("건물 앞이에요."),
                              customDropdownItem("도착했어요."),
                              customDropdownItem("쪽지를 확인해주세요."),
                            ],
                            onChanged: (String? value) {
                              (contents.last['contents'] == "완료했어요!") ? warningDialog(context, "이미 완료된 심부름이예요!") : sendValue(value);
                            },
                            dropdownStyleData: DropdownStyleData(
                              offset: Offset(0, 350),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              )
                            ),
                            selectedItemBuilder: (BuildContext context) {
                              return [
                                "출발했어요.",
                                "지금 물건을 픽업했어요.",
                                "5분 뒤 도착해요.",
                                "10분 뒤 도착해요.",
                                "건물 앞이에요.",
                                "도착했어요.",
                                "쪽지를 확인해주세요."
                              ].map<Widget>((String item) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.01,
                                      color: Color(0xff232323),
                                    ),
                                  ),
                                );
                              }).toList();
                            },


                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 11.25, left: 21),
                child: ElevatedButton(
                  onPressed:
                      () {
                        (contents.last['contents'] == "완료했어요!") ?
                        warningDialog(context, "이미 완료된 심부름이예요!") :
                        confirmDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7C3D1A),
                    fixedSize: Size(318, 45), // 너비와 높이
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // 테두리 둥글기 설정 (0은 둥글지 않음)
                    ),
                  ),
                  child: Container(
                    width: 318,
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      '심부름 완료',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.01,
                        color: Color(0xffFFFFFF),
                      ),
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