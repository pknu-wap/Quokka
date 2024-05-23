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
  final String contents; //메시지
  final String created; //메시지 생성 시간
  const Status_Content_Widget({
    Key? key,
    required this.contents,
    required this.created,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 320, height: 70, //메시지 1개
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container( width: 247.18, height: 42.79,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Color(0xffC5AC9E),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text("${contents}",
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.01,
                    fontSize: 15,
                    color: Color(0xff232323)),
              ),
            ), //
            Container(
              child: Column(
                children: [
                  Container( width: 35.43, height: 35.43,
                      margin: EdgeInsets.only(top: 8.28, left: 7.04),
                      child: Image.asset('assets/images/Quokka.png')),
                  Container(
                    margin: EdgeInsets.only(left: 7.04, top: 5.3),
                    child: Text("${created}",
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.01,
                          fontSize: 14,
                          color: Color(0xff747474)),
                    ),
                  ),

                ],
              ),
            ),// 제목
          ],
        ),
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
  List<Map<String, dynamic>> contents = [];
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
                Container(width: 355, height: 471.79,
                  margin: EdgeInsets.only(left: 3.45, top: 20.13),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    //color: Colors.blue,
                    border: Border(
                      top: BorderSide(color: Colors.transparent, width: 1,),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(width: 320, height: 70, //메시지 1개
                    child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container( width: 247.18, height: 42.79,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5AC9E),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text("출발했어요",
                                    style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.01,
                                        fontSize: 15,
                                        color: Color(0xff232323)),
                                  ),
                                ), //
                                Container(
                                  child: Column(
                                    children: [
                                      Container( width: 35.43, height: 35.43,
                                          margin: EdgeInsets.only(top: 8.28, left: 7.04),
                                          child: Image.asset('assets/images/Quokka.png')),
                                      Container(
                                        margin: EdgeInsets.only(left: 7.04, top: 5.3),
                                        child: Text("11:20",
                                          style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.01,
                                              fontSize: 14,
                                              color: Color(0xff747474)),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),// 제목

                              ],
                            ),
                          ),
                    ),
                      Container(width: 320, height: 70, //메시지 1개
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container( width: 247.18, height: 42.79,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffC5AC9E),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text("지금 물건을 픽업했어요!",
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.01,
                                      fontSize: 15,
                                      color: Color(0xff232323)),
                                ),
                              ), //
                              Container(
                                child: Column(
                                  children: [
                                    Container( width: 35.43, height: 35.43,
                                        margin: EdgeInsets.only(top: 8.28, left: 7.04),
                                        child: Image.asset('assets/images/Quokka.png')),
                                    Container(
                                      margin: EdgeInsets.only(left: 7.04, top: 5.3),
                                      child: Text("11:30",
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.01,
                                            fontSize: 14,
                                            color: Color(0xff747474)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),// 제목

                            ],
                          ),
                        ),
                      ),
                      Container(width: 320, height: 70, //메시지 1개
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container( width: 247.18, height: 42.79,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffC5AC9E),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text("5분 뒤 도착해요!",
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.01,
                                      fontSize: 15,
                                      color: Color(0xff232323)),
                                ),
                              ), //
                              Container(
                                child: Column(
                                  children: [
                                    Container( width: 35.43, height: 35.43,
                                        margin: EdgeInsets.only(top: 8.28, left: 7.04),
                                        child: Image.asset('assets/images/Quokka.png')),
                                    Container(
                                      margin: EdgeInsets.only(left: 7.04, top: 5.3),
                                      child: Text("11:49",
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.01,
                                            fontSize: 14,
                                            color: Color(0xff747474)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),// 제목

                            ],
                          ),
                        ),
                      ),
                      Container(width: 320, height: 70, //메시지 1개
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container( width: 247.18, height: 42.79,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xff7C3D1A),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text("완료했어요 !",
                                  style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.01,
                                      fontSize: 15,
                                      color: Color(0xffFFFFFF)),
                                ),
                              ), //
                              Container(
                                child: Column(
                                  children: [
                                    Container( width: 35.43, height: 35.43,
                                        margin: EdgeInsets.only(top: 8.28, left: 7.04),
                                        child: Image.asset('assets/images/smiley Quokka.png')),
                                    Container(
                                      margin: EdgeInsets.only(left: 7.04, top: 5.3),
                                      child: Text("12:04",
                                        style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.01,
                                            fontSize: 14,
                                            color: Color(0xff747474)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),// 제목

                            ],
                          ),
                        ),
                      ),
                        ],
                      ),),
          // Container(
          //   width: 320, height: 55.54,
          //   margin: EdgeInsets.only(left: 3.45),
          //   decoration: BoxDecoration(
          //     color: Color(0xffEDEDED),
          //     //color: Colors.blue,
          //     border: Border(
          //       bottom: BorderSide(color: Colors.transparent, width: 1,),
          //       ),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // ),

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
