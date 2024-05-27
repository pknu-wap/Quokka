import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/main_post_page.dart';
import 'package:front/request.dart';

class MainShowErrand extends StatefulWidget {
  final int errandNo;

  MainShowErrand({Key? key, required this.errandNo}) : super(key: key);

  @override
  State createState() => _MainErrandCheckState();
}

class _MainErrandCheckState extends State<MainShowErrand> {
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
                          Container(
                            margin: EdgeInsets.only(left: 17.55, right: 20.99),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                print("확인했어요. 버튼 클릭!");
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Color(0xff7C3D1A)),
                                // 버튼의 크기 정하기
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(151.73, 49.7)),
                                // 버튼의 모양 변경하기
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      // 원하는 모양에 따라 BorderRadius 조절
                                      side: BorderSide(
                                        color: Color(0xffFF6767),
                                        width: 1,
                                      )),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/Trash_can_2_.png',
                                    // Replace with your image asset path
                                    width: 17.35, // Adjust the size as needed
                                    height: 21.11, // Adjust the size as needed
                                  ),
                                  SizedBox(width: 8.3),
                                  // Adjust the space between icon and text as needed
                                  Text(
                                    '삭제하기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
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
                              color: Color(0xff545454),
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
