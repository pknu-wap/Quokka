import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/main_post_page.dart';
import 'package:front/mainshowerrand/showerrandwidget/showerrandwidget.dart';
import 'package:front/request.dart';
import 'package:intl/intl.dart';


class MainShowErrand extends StatefulWidget {
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