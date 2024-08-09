import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/status/status_icons/map.dart';
import 'package:front/screens/status/status_icons/re-show_errand.dart';
import 'package:front/widgets/button/brown_button.dart';
import 'package:front/widgets/text/button_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../screens/main/errand_list/errand_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                side: BorderSide(color: Color(0xffB6B6B6), width: 1.w),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  // padding: EdgeInsets.all(20),
                  width: 323.w,
                  height: 214.h,
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), //배경색
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30.h),
                        child: SvgPicture.asset(
                          'assets/images/smile_quokka.svg',
                          width: 70.w,
                          height: 70.h,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12.h),
                        child: Text(
                          "평가해주셔서 감사합니다!",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            letterSpacing: 0.00,
                            color: Color(0xff1A1A1A),
                          ),
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(281.1.w, 47.25.h)),
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
                              fontSize: 15.sp,
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
              side: BorderSide(color: Color(0xffB6B6B6), width: 1.w),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                width: 323.w,
                height: 343.h,
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
                          Container( margin: EdgeInsets.only(top: 19.h, left: 22.w),
                            child: Text(
                              '평가하기',
                              style: TextStyle(fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                letterSpacing: 0.00,
                                color: Color(0xff616161),),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 177.w), //원래 197인데 잘려서 줄여놓음
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Color(0xff8D8D8D),
                                size: 35.sp,),
                              onPressed: () {
                                
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 19.h, left: 22.w, right: 50.w),
                      child:  Text(
                        '더 나은 거래를 위해 오늘의 거래를 평가해주세요!',
                        style: TextStyle(fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          letterSpacing: 0.00,
                          color: Color(0xff404040),),),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 0.w, right: 50.w),
                        child:  Text('상대방 평가 후 나의 평가를 확인할 수 있어요.',
                          style: TextStyle(fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            letterSpacing: 0.00,
                            color: Color(0xff404040),),),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 18.71.h, left: 27.w, right: 31.w),
                        child: Container(
                            width: 265.w,
                            child: Divider(
                                color: Color(0xffBCBCBC),
                                thickness: 0.5))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: SvgPicture.asset(
                            index < _rating
                                ? 'assets/images/quokka_point_O.svg'
                                : 'assets/images/quokka_point_X.svg',
                            width: 39.57.w,
                            height: 39.99.h,
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
                      margin: EdgeInsets.only(top: 15.h),
                      child: Text(ratingTexts[_rating],
                        style: TextStyle(fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          letterSpacing: 0.00,
                          color: Color(0xff1A1A1A),),),),
                    Visibility(
                      visible: _rating > 0,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          '($_rating / 5) 점',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                            letterSpacing: 0.00,
                            color: Color(0xff1A1A1A),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18.h, left: 11.5.w, right: 11.5.w),
                      child: ElevatedButton(
                        onPressed: _rating == 0 ? (){}
                            : () {
                          scoreOther(_rating);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff7C3D1A),
                          fixedSize: Size(318.w, 45.h), // 너비와 높이
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // 테두리 둥글기 설정 (0은 둥글지 않음)
                          ),
                        ),
                        child: Container(
                          width: 300.w,
                          height: 45.h,
                          alignment: Alignment.center,
                          child: Text(
                            '평가 완료했어요',
                            style: TextStyle(
                              fontSize: 15.sp,
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
              width: 320.w,
              height: 70.h, // 메시지 1개
              margin: EdgeInsets.only(top: 21.87.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 247.18.w,
                    height: 42.79.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25.r),
                          offset: Offset(0.w, 5.h),
                          blurRadius: 12.w,
                          spreadRadius: 0.r,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 15.w),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          contents == "완료했어요!"
                              ? 'assets/images/dark_speech_bubble_R.svg'
                              : 'assets/images/light_speech_bubble_R.svg',
                          width: 247.18.w,
                          height: 42.79.h,
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
                                fontSize: 15.sp,
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
                          width: 35.43.w,
                          height: 35.43.h,
                          margin: EdgeInsets.only(top: 8.28.h, left: 7.04.w),
                          child: SvgPicture.asset(
                            contents == "완료했어요!"
                                ? 'assets/images/status_smile_quokka.svg'
                                : 'assets/images/status_quokka.svg',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.91.w, top: 3.84.h),
                          child: Text(
                            extractTime(created),
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.01,
                              fontSize: 14.sp,
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
      width: 276.72.w,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffDCDCDC), width: 1.w),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 13.0.h, horizontal: 10.0.w),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 15.sp,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.01,
          color: Color(0xff232323),
        ),
      ),
    ),
  );
}
class HistoryDoerrand extends StatefulWidget {
  final int errandNo;
  const HistoryDoerrand({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  State<HistoryDoerrand> createState() => _HistoryDoerrandState();
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

class _HistoryDoerrandState extends State<HistoryDoerrand> with TickerProviderStateMixin{

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
  List<Map<String, dynamic>> contents = [
    {
      "contents": "출발했어요.",
      "created": "2024-08-04T04:44:56.282Z"
    },
    {
      "contents": "지금 물건을 픽업했어요.",
      "created": "2024-08-04T05:01:23.456Z"
    },
    {
      "contents": "10분 뒤 도착해요.",
      "created": "2024-08-04T06:15:37.789Z"
    },
    {
      "contents": "5분 뒤 도착해요.",
      "created": "2024-08-04T07:30:45.123Z"
    },
    {
      "contents": "완료했어요!",
      "created": "2024-08-04T08:45:59.456Z"
    }
  ];
  List<AnimationController> controllers = [];
  List<Animation<double>> animations = [];
  bool isCompleted = true;
  ScrollController _scrollController = ScrollController();
  void completeCheck()
  {
    if(contents.isNotEmpty && contents.last['contents'] == '완료했어요!')
      isCompleted = true;
    else
      isCompleted = false;
    return;
  }
  // 심부름 완료

  void scrollToBottom() {
    if (contents.length > 5) {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final offset = 50.h; // 더 아래로 스크롤하고 싶은 거리

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
    addItemAnimation();
    addItemAnimation();
    addItemAnimation();
    addItemAnimation();
    addItemAnimation();
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
                      margin: EdgeInsets.only(top: 86.h, left: 26.w),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset(
                          'assets/images/arrow_back.svg',
                          color: Color(0xff6B6B6B),
                        ),
                      ),
                    ),
                    Container( height: 25.h,
                      margin: EdgeInsets.only(top: 80.h, left: 12.w),
                      child: Text(
                        '수행한 심부름',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'paybooc',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.01,
                          color: Color(0xff111111),
                        ),
                      ),
                    ),
                    Container(
                      width: 19.02.w,
                      height: 26.15.h,
                      margin: EdgeInsets.only(top: 73.65.h, left: 117.05.w),
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
                        icon: SvgPicture.asset(
                          'assets/images/map.svg',
                          color: Color(0xffB4B5BE),
                        ),
                      ),
                    ),
                    Container(
                      width: 20.w,
                      height: 25.81.h,
                      margin: EdgeInsets.only(top: 74.h, left: 13.w),
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
                        icon: SvgPicture.asset(
                          'assets/images/errand.svg',
                          color: Color(0xffB4B5BE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(child: Container(width: 320.w, height: 422.h,
                margin: EdgeInsets.only(left: 20.w, top: 21.21.h),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  //color: Colors.blue,
                  border: Border(
                    top: BorderSide(color: Colors.transparent, width: 1.w,),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 0.1.h, bottom: 45.h),
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
                    width: 320.w,
                    height: 55.54.h,
                    margin: EdgeInsets.only(left: 20.w),
                    decoration: BoxDecoration(
                      color: Color(0xffEDEDED),
                      border: Border(
                        top: BorderSide(color: Colors.transparent, width: 1.w,),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 284.99.w,
                        height: 31.53.h,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xffBDBDBD),
                            width: 1.w,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            hint: Row(
                              children: [
                                Container(
                                  child:  SvgPicture.asset(
                                    'assets/images/paper-plane.svg',
                                    color: Color(0xffADADAD),
                                  ),
                                ),
                                SizedBox(width: 4.59.w), // Adjust the space between icon and text
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
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

                            },
                            dropdownStyleData: DropdownStyleData(
                                offset: Offset(0.w, 350.h),
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
                                      fontSize: 15.sp,
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
                margin: EdgeInsets.only(top: 11.25.h, left: 21.w),
                child: ElevatedButton(
                  onPressed:
                      () {
                          Navigator.of(context).pop();
                  },
                  style: brownButton318(Color(0xFF7C3D1A)),
                  child: buttonText("확인했어요"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}