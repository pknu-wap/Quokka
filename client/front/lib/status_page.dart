import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Status_Content{//진행중인 심부름이 간략하게 담고 있는 정보들
  String contents; //메시지
  String created; //메시지 생성 시간
  Status_Content(this.contents, this.created);
  factory Status_Content.fromJson(Map<String, dynamic> json) {
    return Status_Content(
      json['contents'],
      json['created'],
    );
  }
}
class Status_Content_Widget extends StatelessWidget {
  final String contents; // 메시지
  final String created; // 메시지 생성 시간

  const Status_Content_Widget({
    Key? key,
    required this.contents,
    required this.created,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    created,
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
            margin: EdgeInsets.only(left: 8.08),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Image.asset(
                  contents == "완료했어요!"
                      ? 'assets/images/진한말풍선.png'
                      : 'assets/images/연한말풍선.png',
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
    );
  }
}
class statuspage extends StatefulWidget {
  final int errandNo;
  const statuspage({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  State<statuspage> createState() => _statuspageState();
}
class _statuspageState extends State<statuspage> {
  late int errandNo;
  List<Map<String, dynamic>> contents = [
    {
      'contents': '심부름꾼이 출발했어요 !',
      'created': '11:20',
    },
    {
      'contents': '지금 물건을 픽업 했어요 !',
      'created': '11:30',
    },
    {
      'contents': '5분 뒤 도착해요!',
      'created': '11:49',
    },
    {
      'contents': '완료했어요!',
      'created': '11:55',
    },
    //테스트 코드
  ];
  ScrollController _scrollController = ScrollController();
  void initState()
  {
    super.initState();
    errandNo = widget.errandNo;
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
                        margin: EdgeInsets.only(top: 80, left: 4),
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
                    itemCount: contents.length,
                    itemBuilder: (BuildContext context, int index){
                      return Status_Content_Widget(
                        contents: contents[index]["contents"],
                        created: contents[index]["created"],
                      );
                    }
                ),
                  ),),
          Container(
            margin: EdgeInsets.only(top: 24.08, left: 21),
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 실행될 코드
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Color(0xffB99988),
                  backgroundColor: Color(0xff7C3D1A),// 배경색
                fixedSize: Size(318, 45), // 너비와 높이
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 테두리 둥글기 설정 (0은 둥글지 않음)
                ),
              ),
              child: Container( width: 318, height: 45,
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
