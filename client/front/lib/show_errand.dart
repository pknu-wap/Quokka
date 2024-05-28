import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/main_post_page.dart';
import 'package:front/request.dart';
import 'package:intl/intl.dart';

class TableScreen extends StatelessWidget {
  final int errandNo;
  final String title;
  final String name;
  final String createdDate;
  final String due;
  final String destination;
  final String detail;
  final int reward;
  final bool isCash;

  TableScreen({
    required this.errandNo,
    required this.title,
    required this.name,
    required this.createdDate,
    required this.due,
    required this.destination,
    required this.detail,
    required this.reward,
    required this.isCash,
  });
  late DateTime datetime = DateFormat('yyyy-MM-dd').parse(createdDate); // 요청일 String을 DateTime으로 변환
  // 날짜를 yyyy.MM.dd 형식으로 변환하는 함수
  String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  late final List<Map<String, dynamic>> list = [
    {
      'text': "제목",
      'content': utf8.decode(title.runes.toList()),
    },
    {
      'text': "글 쓴 사람",
      'content': utf8.decode(name.runes.toList()),
    },
    {
      'text': "요청일",
      'content': formatDate(datetime),
    },
    {
      'text': "일정",
      'content': "${due}까지",
    },
    {
      'text': "장소",
      'content': utf8.decode(destination.runes.toList()),
    },
    {
      'text': "요청 사항",
      'content': utf8.decode(detail.runes.toList()),
    }
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle1 = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w300,
      fontSize: 11,
      letterSpacing: 0.001,
      color: Color(0xffFFFFFF),
    );
    final TextStyle textStyle2 = TextStyle(
      fontFamily: 'SANGJUDajungdagam',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      letterSpacing: 0.00,
      color: Color(0xff111111),
    );

    // 심부름 사항 표
    return Container(
      width: 238,
      height: 186,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(62),
          1: FixedColumnWidth(176),
        },
        border: TableBorder(
          borderRadius: BorderRadius.circular(10),
          // top: BorderSide(color: Colors.blue, width: 2), // 맨 윗 줄
          // bottom: BorderSide(color: Colors.blue, width: 2), // 맨 아랫 줄
          // left: BorderSide(color: Colors.blue, width: 2), // 맨 앞 줄
          // right: BorderSide(color: Colors.blue, width: 2), // 맨 뒷 줄
          horizontalInside: BorderSide(color: Color(0xffF1F1F1), width: 1), // 안 쪽 가로 줄
        ),
        children: List.generate(6, (index) {
          return TableRow(children: [
            TableCell(
                child: Container(
                  height: 30,
                  color: Color(0xff674333),
                 child: Center(child: Text(list[index]['text'], style: textStyle1,))), // 가운데 정렬
                ),
            TableCell(
              child: Container(
                height: 30,
                  padding: EdgeInsets.all(9), // 왼쪽 정렬 띄우기 위함
                  color: Color(0xffFFFFFF),
                child: Align(
                  alignment: Alignment.centerLeft, // 왼쪽 정렬
                    child: Text(list[index]['content'], style: textStyle2,))),
            ),
           ]);
         }),
      ),
    );
  }
}


class ShowErrandWidget extends StatelessWidget {
  final int errandNo;
  final String title;
  final String name;
  final String createdDate;
  final String due;
  final String destination;
  final String detail;
  final int reward;
  final bool isCash;

  ShowErrandWidget({
    required this.errandNo,
    required this.title,
    required this.name,
    required this.createdDate,
    required this.due,
    required this.destination,
    required this.detail,
    required this.reward,
    required this.isCash,
  });

  // 심부름 요청서 상세 페이지
  @override
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat('###,###,###,###');
    return Container(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 324, height: 576,
            decoration: BoxDecoration(
              color: Color(0xffFCFCF9),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start, // 세로축 기준으로 왼쪽 정렬
              children:[
                // 심부름 요청서 제목
                  Container(
                    margin: EdgeInsets.only(top: 33, left: 93, right: 91),
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
                  // 심부름 요청서 설명
                Container(
                    margin: EdgeInsets.only(top: 13.01),
                    child: Row(
                      children: [
                        //사랑하는
                        Container(
                          margin: EdgeInsets.only(left: 48),
                          child: Text(
                            "사랑하는",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              letterSpacing: 0.00,
                              color: Color(0xff111111),
                            ),
                          ),
                        ),
                        // 밑줄 텍스트 필드?
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "__________",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              letterSpacing: 0.00,
                              color: Color(0xff111111),
                            ),
                          ),
                        ),
                        //님의... 길이에 따라 줄바꿈 텍스트 생성
                        Container(
                          width: 150, // 텍스트 가로 너비 제한해주기(가로 너비보다 길어지면 자동 줄바꿈)
                          margin: EdgeInsets.only(left: 2.82),
                          child: Text(
                            "님의 탁월함과 열정에 감사하며",
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
                    )),
              Container(
                  width: 217,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            // strutStyle: StrutStyle(fontSize: 16.0),
                            textAlign: TextAlign.center, // 텍스트 가운데 정렬
                            text: TextSpan(
                                text:
                                "아래와 같이 심부름을 요청합니다. 심부름 사항을 확인 후 완료 버튼을 통해 심부름을 확정해주시면 감사하겠습니다.",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11,
                                  letterSpacing: 0.00,
                                  color: Color(0xff111111),
                                )),
                          )
                      ),
                    ],
                  )),
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
                    TableScreen(
                      errandNo: errandNo,
                      title: title,
                      name: name,
                      createdDate: createdDate,
                      due: due,
                      destination: destination,
                      detail: detail,
                      reward: reward,
                      isCash: isCash,
                    ),
                  // 금액 및 결제 텍스트
                  Container(
                      margin: EdgeInsets.only(top: 13.65),
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
                    ],
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


class MainShowErrand extends StatefulWidget {
  // final int errandNo;
  // final String title;
  // final String name;
  // final String createdDate;
  // final String due;
  // final String destination;
  // final String detail;
  // final int reward;
  // final bool isCash;
  final Map<String, dynamic> errands;



  MainShowErrand({
    Key? key,
    required this.errands
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
  late bool isCash;

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
    isCash = widget.errands["isCash"];

    print(title);
    print(name);
    print(createdDate);
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 심부름 요청서 상세 부분
                          Flexible(
                              child: Container(
                                width: 324,
                                height: 576,
                                margin: EdgeInsets.only(top: 40, left: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Color(0xffFCFCF9),
                                ),
                                child:ShowErrandWidget(
                                        errandNo: errandNo,
                                        title: title,
                                        name: name,
                                        createdDate: createdDate,
                                        due: due,
                                        destination: destination,
                                        detail: detail,
                                        reward: reward,
                                        isCash: isCash,
                                      )
                        ),
                      ),

                          // 확인했어요. 버튼
                          // Container(
                          //   margin: EdgeInsets.only(left: 20.5, right: 21.5, top: 11),
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       print("확인했어요. 클릭");
                          //       // 심부름 요청서 팝업 느낌으로 띄우기
                          //       // Navigator.of(context).push(
                          //       //   MaterialPageRoute(
                          //       //       builder: (context) => MainShowErrand(),/*errandNo: posts[index]["errandNo"])*/
                          //       //   ),);
                          //     },
                          //     style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all<Color>(
                          //           Color(0xFF7C3D1A)),
                          //       // 버튼의 크기 정하기
                          //       minimumSize:
                          //       MaterialStateProperty.all<Size>(Size(318, 46.65)),
                          //       // 버튼의 모양 변경하기
                          //       shape:
                          //       MaterialStateProperty.all<RoundedRectangleBorder>(
                          //         RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(
                          //               5), // 원하는 모양에 따라 BorderRadius 조절
                          //         ),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       '확인했어요.',
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //         fontFamily: 'Pretendard',
                          //         fontWeight: FontWeight.w600,
                          //         color: Color(0xFFFFFFFF),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          ],
                        ),
                      ),
                  ],
                )),

            // 내비게이션 바
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    width: 364,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(
                        color: Color(0xffCFCFCF),
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(185, 185, 185, 0.25),
                          offset: Offset(5, -1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.only(
                                left: 44, top: 20.0, bottom: 17.32),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Main_post_page(),
                                  ),
                                );
                              },
                              icon: Image.asset(
                                'assets/images/home_icon.png',
                                color: Color(0xffADADAD),
                              ),
                            ),
                          ),
                          Container(
                            width: 19.31,
                            height: 23.81,
                            margin:
                            const EdgeInsets.only(top: 20.0, bottom: 17.32),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/human_icon.png',
                                color: Color(0xffADADAD),
                              ),
                            ),
                          ),
                          Container(
                            width: 22.0,
                            height: 22,
                            margin:
                            const EdgeInsets.only(top: 20.0, bottom: 17.32),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Request(),
                                  ),
                                );
                              },
                              icon: Image.asset(
                                'assets/images/add_icon.png',
                                color: Color(0xffADADAD),
                              ),
                            ),
                          ),
                          Container(
                            width: 21.95,
                            height: 24.21,
                            margin: const EdgeInsets.only(
                                top: 20.0, bottom: 17.32, right: 43.92),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/history_icon.png',
                                color: Color(0xffADADAD),
                              ),
                            ),
                          ),
                        ])))
          ],
        ),
      ),
    );
  }
}
