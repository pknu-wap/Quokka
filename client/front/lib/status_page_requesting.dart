import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';


import 'home.dart';

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
String extractTime(String timeData) {
  // DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(timeData);

  // 시간과 분 추출
  String hours = dateTime.hour.toString().padLeft(2, '0');
  String minutes = dateTime.minute.toString().padLeft(2, '0');

  return '$hours:$minutes';
}
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
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()));
    }
    else {
      print(response.body);
    }
  }
  void scoreConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return  Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: 300, height: 245,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 다이얼로그의 크기를 콘텐츠에 맞게 조정
                children: [
                  Icon(
                    Icons.warning,
                    color: Color(0xffAD8772),
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "지금 나가면 평가할 수 없어요!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300, height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffAD8772),
                        foregroundColor: Color(0xffFFFFFF),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "평가를 하지 않고 나가기",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 300, height: 45,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xffAD8772),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(color: Color(0xffAD8772)),
                      ),
                      child: Text(
                        "취소",
                        textAlign: TextAlign.center,
                      ),
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(width: 323, height: 343,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            border: Border.all(color: Color(0xffB6B6B6), width: 1,),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container( margin: EdgeInsets.only(top: 19, left: 22),
                      child: Text(
                        '평가하기',
                        style: TextStyle(fontFamily: 'Pretendard',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xff616161),),),
                    ),
                    Container( margin: EdgeInsets.only(left: 177), //원래 197인데 잘려서 줄여놓음
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          scoreConfirmDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container( width: 300, height: 16,
                margin: EdgeInsets.only(top: 19, left: 22, right: 40),
                child:  Text('더 나은 거래를 위해 오늘의 거래를 평가해주세요!',
                  style: TextStyle(fontFamily: 'Pretendard',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xff404040),),),
              ),
              Flexible(
                child: Container( width: 251, height: 16,
                  margin: EdgeInsets.only(left: 22, right: 50),
                  child:  Text('상대방 평가 후 나의 평가를 확인할 수 있어요.',
                    style: TextStyle(fontFamily: 'Pretendard',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xff404040),),),
                ),
              ),
              Container( margin: EdgeInsets.only(top: 18.72, left: 27, right: 31),
                  child: Container(width: 265, child: Divider(color: Color(0xffBCBCBC), thickness: 0.5))),
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
              Text(ratingTexts[_rating],
                style: TextStyle(fontFamily: 'Pretendard',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xff1A1A1A),),),
              if (_rating > 0)
                Text(
                  '($_rating / 5) 점',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff1A1A1A),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(top: 28.5, left: 11.5, right: 11.5),
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
      ),
    );
  }
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
          height: 85, // 메시지 1개
          margin: EdgeInsets.only(top: 21.87),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15.09),
                child: Column(
                  children: [
                    Container(
                      width: 35.43,
                      height: 35.43,
                      margin: EdgeInsets.only(top: 8.28, left: 17.04),
                      child: Image.asset(
                        contents == "완료했어요!"
                            ? 'assets/images/smiley Quokka.png'
                            : 'assets/images/Quokka.png',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 21.55, top: 2.48),
                      child: Text(
                        //created,
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
              Container(
                width: 276.69,
                height: 42.79,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 8.08),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Image.asset(
                      contents == "완료했어요!"
                          ? 'assets/images/진한말풍선L.png'
                          : 'assets/images/연한말풍선L.png',
                      width: 276.69,
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
            ],
          ),
        ),
      );
    }
    );
  }
}
String connectNo = "";

class statuspageQ extends StatefulWidget {
  final int errandNo;
  const statuspageQ({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  State<statuspageQ> createState() => _statuspageQState();
}
class _statuspageQState extends State<statuspageQ> with TickerProviderStateMixin{

  late StompClient stompClient;
  void onConnect(StompClient stompClient,StompFrame frame) {
    stompClient.subscribe(
      destination: '/queue/$connectNo',
      callback: (frame) {
        setState(() {
          contents.add(json.decode(frame.body!));
          addItemAnimation();
          scrollToBottom();
          completeCheck();
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
    setState(() {});
    return;
  }
  Future<void> statusMessageInit() async{
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
  receiveValue() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}";
    String? token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      print('contents add 200');
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        StatusContent c1 = StatusContent.fromJson(item);
        contents.add({
          "contents": c1.contents,
          "created": c1.created,
        });
      }
      completeCheck();
      setState(() {});
    }
    else {
      print("비정상 요청");
    }
  }
  order_complete() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}$connectNo/complete/order";
    String? token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
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
  void confirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 300,
            height: 203,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //배경색
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check, // 확인 아이콘으로 변경
                  color: Color(0xffAD8772),
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  "심부름을 완료하시겠어요?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "꼭 심부름이 완료되었을 때 눌러야 해요.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffB08B76),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          order_complete();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffAD8772), // 갈색으로 설정
                          foregroundColor: Color(0xffFFFFFF),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("확인"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xffAD8772),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(color: Color(0xffAD8772)),
                        ),
                        child: Text("취소"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void scoreConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 300,
            height: 203,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF), //배경색
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check, // 확인 아이콘으로 변경
                  color: Color(0xffAD8772),
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  "나가면 더 이상 평가할 수 없어요!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffAD8772), // 갈색으로 설정
                          foregroundColor: Color(0xffFFFFFF),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("평가를 하지 않고 나가기"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xffAD8772),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(color: Color(0xffAD8772)),
                        ),
                        child: Text("취소"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void initState()
  {
    super.initState();
    errandNo = widget.errandNo;
    connectNo = errandNo.toString();
    statusMessageInit().then((_) {
      completeCheck();
    });

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
                          onPressed: () {},
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
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/errand.png',
                            color: Color(0xffB4B5BE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(child: Container(width: 355, height: 471.79,
                  margin: EdgeInsets.only(left: 3.45, top: 20.13),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    //color: Colors.blue,
                    border: Border(
                      top: BorderSide(color: Colors.transparent, width: 1,),
                    ),
                    borderRadius: BorderRadius.circular(10),
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
                Container(
                  margin: EdgeInsets.only(top: 24.08, left: 21),
                  child: ElevatedButton(
                    onPressed: isCompleted
                        ? () {
                           confirmDialog(context);
                        }
                        : () { },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCompleted
                          ? Color(0xff7C3D1A)
                          : Color(0xff7C3D1A).withOpacity(0.5),
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
