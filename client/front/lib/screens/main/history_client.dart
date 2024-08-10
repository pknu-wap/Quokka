import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/status/status_icons/map.dart';
import 'package:front/screens/status/status_icons/re-show_errand.dart';
import 'package:front/utils/button_utill.dart';
import 'package:front/widgets/button/brown_button.dart';
import 'package:front/widgets/text/button_text.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
              height: 85.h, // 메시지 1개
              margin: EdgeInsets.only(top: 21.87.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15.09.h),
                    child: Column(
                      children: [
                        Container(
                          width: 35.43.w,
                          height: 35.43.h,
                          margin: EdgeInsets.only(top: 8.28.h, left: 17.04.w),
                          child: SvgPicture.asset(
                            contents == "완료했어요!"
                                ? 'assets/images/status_smile_quokka.svg'
                                : 'assets/images/status_quokka.svg',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 21.55.w, top: 2.2.h),
                          child: Text(
                            //created,
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
                  Container(
                    width: 276.69.w,
                    height: 42.79.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25.r),
                          offset: Offset(3.w, 5.h),
                          blurRadius: 12.w,
                          spreadRadius: 0.r,
                        ),
                      ],

                    ),
                    margin: EdgeInsets.only(left: 8.08.w),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          contents == "완료했어요!"
                              ? 'assets/images/dark_speech_bubble_L.svg'
                              : 'assets/images/light_speech_bubble_L.svg',
                          width: 276.69.w,
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
                ],
              ),
            ),
          );
        }
    );
  }
}
String connectNo = "";

class HistoryRequest extends StatefulWidget {
  final int errandNo;
  const HistoryRequest({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  State<HistoryRequest> createState() => _HistoryRequest();
}
class _HistoryRequest extends State<HistoryRequest> with TickerProviderStateMixin{
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
    setState(() {});
    return;
  }

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
                        '요청한 심부름',
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
                      margin: EdgeInsets.only(top: 73.65.h, left: 113.05.w),
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
              Flexible(child: Container(width: 355.w, height: 471.79.h,
                margin: EdgeInsets.only(left: 3.45.w, top: 20.13.h),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  //color: Colors.blue,
                  border: Border(
                    top: BorderSide(color: Colors.transparent, width: 1.w,),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 0.1.h, bottom: 45.w),
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
                margin: EdgeInsets.only(top: 24.08.h, left: 21.w),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: brownButton318(decideButtonColor(isCompleted)),
                  child: buttonText("확인 했어요"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}