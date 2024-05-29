import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/errand_check.dart';
import 'package:front/mainshowerrand/showerrandwidget/stamp.dart';
import 'package:front/mainshowerrand/showerrandwidget/tablescreen/tablescreen1.dart';
import 'package:front/mainshowerrand/showerrandwidget/tablescreen/tablescreen2.dart';

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
  final bool isCheckButtonVisible;
  final bool isStampVisible;
  final String nickName;

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
    required this.isCheckButtonVisible,
    required this.isStampVisible,
    required this.nickName,
  });

  String realName = "김수현"; // 심부름 요청한 사람 -> 밑줄 부분에 들어갈 이름(연동 필요)

  // 심부름 요청서 상세 페이지
  @override
  Widget build(BuildContext context) {
    return Container(
            width: 324, height: 576,
            decoration: BoxDecoration(
              color: Color(0xffFCFCF9),
            ),
            child: Column(
              children:[
                // 닫기 버튼
                GestureDetector(
                  onTap: () { // 버튼 클릭 시 이전 페이지인 게시글 페이지로 이동
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MainErrandCheck(errandNo: errandNo),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 280, top: 8),
                    color: Colors.transparent,
                    child: Icon(
                      Icons.close,
                      color: Color(0xff8E8E8E),
                    ),
                  ),
                ),
                // 심부름 요청서 제목
                Container(
                  margin: EdgeInsets.only(top: 4, left: 93, right: 91),
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
                          child: Transform.translate(
                            offset: Offset(0, -3),
                          child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                                color: Color(0xff111111),
                            width: 0.5)), // 밑줄 스타일링
                          ),
                          child: Text(
                            '                  ',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                              letterSpacing: 0.00,
                              color: Color(0xff111111),
                             ),
                            ),
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
                  // margin: EdgeInsets.only(top: 17.15),
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
                              margin: EdgeInsets.only(top: 17.15, left: 0),
                              child: Text(
                                "(주) ${utf8.decode(name.runes.toList())}",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  letterSpacing: 0.001,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            if(nickName != "닉 네 임")
                            // 닉네임 -> 글 보기 하는 사람 -> 닉네임
                            Container(
                              margin: EdgeInsets.only(top: 17.15, left: 5),
                              child: Text(
                                nickName,
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
                          margin: EdgeInsets.only(top: 17.15, right: 37),
                          child: Text(
                            "( 서 명 )",
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
                        // Line1.png
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            margin: EdgeInsets.only(top: 41.15, right: 37.5),
                            child: Image.asset("assets/images/Line1.png")
                        ),
                      ),
                      if(isStampVisible)
                      // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장
                      Stamp(),

                    ],
                  ),
                ),

              ],
            ),
    );
  }
}