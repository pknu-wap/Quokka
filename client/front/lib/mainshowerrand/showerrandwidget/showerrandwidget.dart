import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:front/mainshowerrand/showerrandwidget/tablescreen/tablescreen1.dart';
import 'package:front/mainshowerrand/showerrandwidget/tablescreen/tablescreen2.dart';
import 'package:intl/intl.dart';

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
                      Container(
                        margin: EdgeInsets.only(top: 6.68),
                        child: TableScreen1(
                          title: title,
                          name: name,
                          createdDate: createdDate,
                          due: due,
                          destination: destination,
                          detail: detail,
                        ),),

                      // 금액 및 결제 텍스트
                      Container(
                          margin: EdgeInsets.only(top: 7.68),
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
                      // 금액 및 결제 표
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        child: TableScreen2(
                          reward: reward,
                          isCash: isCash,
                        ),),
                    ],
                  ),
                ),
                // (주) 커카글쓴이 닉네임 (서명)
                Container(
                  margin: EdgeInsets.only(top: 17.15),
                  child: Stack(
                    children: [
                      // Center-aligned Row
                      Align(
                        alignment: Alignment.center, // 가운데 정렬
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // 최소한의 너비 가지기
                          children: [
                            // (주) 커카글쓴이 -> 글 쓴 사람 -> name
                            Container(
                              margin: EdgeInsets.only(left: 0),
                              child: Text(
                                "(주)${utf8.decode(name.runes.toList())}",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  letterSpacing: 0.001,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            // 닉네임 -> 글 보기 하는 사람 -> 닉네임
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "닉네임",
                                style: TextStyle(
                                  fontFamily: 'MaruBuri',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  letterSpacing: 0.01,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Right-aligned (서명)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 37),
                          child: Text(
                            "(서명)",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              letterSpacing: 0.001,
                              color: Color(0xffA4A4A4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )


              ],
            ),
          ),


        ],
      ),
    );
  }
}