import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/errand_check.dart';
import 'package:front/main_post_page.dart';
import 'package:front/request.dart';
import 'package:intl/intl.dart';

class ErrandCheckWidget extends StatelessWidget {
  // 심부름 요청서 상세 페이지
  @override
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat('###,###,###,###');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 324, height: 576,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                // 심부름 요청서 제목
                  Container(
                    margin: EdgeInsets.only(top: 26, left: 93, right: 91),
                    child: Text(
                      "심부름 요청서",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
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
                          margin: EdgeInsets.only(left: 13.4),
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
                          margin: EdgeInsets.only(left: 9.1),
                          child: Text(
                            "______",
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
                            " 님의 탁월함과 열정에 감사하며",
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

                //   Container(
                //       margin: EdgeInsets.only(top: 13.01),
                //       child: Row(
                //         children: [
                //           //닉네임
                //           Container(
                //             margin: EdgeInsets.only(left: 13.4),
                //             child: Text(
                //               "${nickname}",
                //               style: TextStyle(
                //                 fontFamily: 'Pretendard',
                //                 fontWeight: FontWeight.w300,
                //                 fontSize: 14,
                //                 letterSpacing: 0.001,
                //                 color: Color(0xff575757),
                //               ),
                //             ),
                //           ),
                //           // 평점 커카 이미지
                //           Container(
                //             margin: EdgeInsets.only(left: 9.1),
                //             child: Image.asset(
                //               'assets/images/score_icon.png',
                //               // Replace with your image asset path
                //               width: 11.77, // Adjust the size as needed
                //               height: 11.77, // Adjust the size as needed
                //               color: Color(0xffCFB6A5),
                //             ),
                //           ),
                //           //평점
                //           Container(
                //             margin: EdgeInsets.only(left: 2.82),
                //             child: Text(
                //               " ${score}점",
                //               style: TextStyle(
                //                 fontFamily: 'Pretendard',
                //                 fontWeight: FontWeight.w300,
                //                 fontSize: 13,
                //                 letterSpacing: -0.03,
                //                 color: Color(0xffCFB6A5),
                //               ),
                //             ),
                //           ),
                //         ],
                //       )),
                // //게시글 제목
                // Container(
                //   margin: EdgeInsets.only(top: 10.59, left: 13.4, right: 18.6),
                //   child: Text(
                //     "${title}",
                //     style: TextStyle(
                //       fontFamily: 'Pretendard',
                //       fontWeight: FontWeight.w600,
                //       fontSize: 20,
                //       letterSpacing: 0.001,
                //       color: Color(0xff111111),
                //     ),
                //   ),
                // ),
                // // 심부름 값
                // Container(
                //   margin: EdgeInsets.only(top: 11.52, left: 13.4),
                //   child: Text(
                //     "\u20A9 ${priceFormat.format(reward)} 원",
                //     style: TextStyle(
                //       fontFamily: 'Pretendard',
                //       fontWeight: FontWeight.w700,
                //       fontSize: 20,
                //       letterSpacing: 0.001,
                //       color: Color(0xff7C3D1A),
                //     ),
                //   ),
                // ),
                // // 상세 주소
                // Container(
                //     margin: EdgeInsets.only(top: 22.06),
                //     child: Row(
                //       children: [
                //         // 마커 이미지
                //         Container(
                //           margin: EdgeInsets.only(left: 18.97),
                //           child: Image.asset(
                //             'assets/images/marker_small.png',
                //             // Replace with your image asset path
                //             width: 12.2, // Adjust the size as needed
                //             height: 16.77, // Adjust the size as needed
                //           ),
                //         ),
                //         // 상세 주소 텍스트
                //         Container(
                //           margin: EdgeInsets.only(left: 7.67),
                //           child: Text(
                //             "상세 주소",
                //             style: TextStyle(
                //               fontFamily: 'Pretendard',
                //               fontWeight: FontWeight.w400,
                //               fontSize: 12,
                //               letterSpacing: 0.001,
                //               color: Color(0xffBC9F9F),
                //             ),
                //           ),
                //         ),
                //         // 상세 주소 정보
                //         Container(
                //           margin: EdgeInsets.only(left: 7),
                //           child: Text(
                //             "${destination}",
                //             style: TextStyle(
                //               fontFamily: 'Pretendard',
                //               fontStyle: FontStyle.normal,
                //               fontWeight: FontWeight.w500,
                //               fontSize: 13,
                //               letterSpacing: 0.001,
                //               color: Color(0xff505050),
                //             ),
                //           ),
                //         ),
                //       ],
                //     )),


              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MainShowErrand extends StatefulWidget {
  final int errandNo;
  final String title;
  final String name;
  final String createdDate;
  final String due;
  final String destination;
  final String detail;
  final int reward;
  final bool isCash;

  MainShowErrand({Key? key,
    required this.errandNo,
    required this.title,
    required this.name,
    required this.createdDate,
    required this.due,
    required this.destination,
    required this.detail,
    required this.reward,
    required this.isCash,
  }) : super(key: key);

  @override
  State createState() => _MainErrandCheckState();
}

class _MainErrandCheckState extends State<MainShowErrand> {
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
    errandNo = widget.errandNo;
    title = widget.title;
    name = widget.name;
    createdDate = widget.createdDate;
    due = widget.due;
    destination = widget.destination;
    detail = widget.detail;
    reward = widget.reward;
    isCash = widget.isCash;
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
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 심부름 요청서 상세 부분
                          Flexible(
                              child: Container(
                                width: 324,
                                height: 576,
                                margin: EdgeInsets.only(top: 5.05, left: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Color(0xffFCFCF9),
                                ),
                                child: ListView.builder(
                                    padding: EdgeInsets.only(top: 0.1, bottom: 45),
                                    itemBuilder: (BuildContext context, int index) {
                                      String srrandtitle = title;
                                      String sname = name;
                                      String screatedDate = createdDate;

                                      return GestureDetector(
                                        // behavior: HitTestBehavior.translucent,
                                        //게시글 전체를 클릭 영역으로 만들어주는 코드
                                        child:
                                                );
                                              }),
                                            ),
                                          ),

                          // 확인했어요. 버튼
                          Container(
                            margin: EdgeInsets.only(left: 20.5, right: 21.5, top: 11),
                            child: ElevatedButton(
                              onPressed: () {
                                print("확인했어요. 클릭");
                                // 심부름 요청서 팝업 느낌으로 띄우기
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //       builder: (context) => MainShowErrand(),/*errandNo: posts[index]["errandNo"])*/
                                //   ),);
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
