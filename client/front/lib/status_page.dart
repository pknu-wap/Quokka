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
    return Container(width: 360, height: 84.4, //메시지 1개
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 26.4, left: 19.14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 32, height: 31,
                    child: Image.asset(
                        'assets/images/running errand.png', width: 32,
                        height: 31,
                        fit: BoxFit.cover
                    ),
                  ), //이미지
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 14.52),
                          child: Text("",
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff923D00)),
                          ),
                        ), //제목
                        Container(
                            margin: EdgeInsets.only(left: 14.52),
                            child: Text("",
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xff9F9F9F)),
                            )), //일정
                      ],
                    ),
                  ), //
                  Expanded(
                      child: Align(alignment: Alignment.topRight,
                        child: Container(
                            margin: EdgeInsets.only(right: 20.77),
                            child: Text("수행 중",
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Color(0xffCFA383)),
                            )
                        ), //텍스트 수행 중/요청 중
                      )), // 텍스트(제목, 일정)
                ],
              ),),
            Container(child: Center(child: Container(width: 317.66,
                child: Divider(color: Color(0xffC8C8C8), thickness: 0.5)))),
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
                    border: Border.all(color: Colors.transparent, width: 1,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(top: 24.08, left: 21),
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 실행될 코드
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffB99988), // 배경색
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
