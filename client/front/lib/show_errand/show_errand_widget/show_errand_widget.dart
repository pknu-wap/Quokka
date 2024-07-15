import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/show_errand/show_errand_widget/stamp/stamp.dart';
import 'package:front/show_errand/show_errand_widget/table/table1.dart';
import 'package:front/show_errand/show_errand_widget/table/table2.dart';
import 'package:front/show_errand/show_errand_widget/textfield_widget.dart';
import '../../main/errand_list/check_errand/check_errand.dart';

class ShowErrandWidget extends StatelessWidget {
  final int errandNo;
  final String title;
  final String name;
  final String createdDate;
  final String due;
  final String destination;
  final String detail;
  final int reward;
  final String status;
  final bool isCash;
  final bool isCheckButtonVisible;
  final bool isStampVisible;
  final String nickName;
  final String realName;

  final EdgeInsets margin;

  ShowErrandWidget({
    required this.errandNo,
    required this.title,
    required this.name,
    required this.createdDate,
    required this.due,
    required this.destination,
    required this.detail,
    required this.reward,
    required this.status,
    required this.isCash,
    required this.isCheckButtonVisible,
    required this.isStampVisible,
    required this.nickName,
    required this.realName,
    required this.margin,
  });

  // 심부름 요청서 상세 페이지
  @override
  Widget build(BuildContext context) {
    return Container(
            width: 324.h, height: 576.h,
            decoration: BoxDecoration(
              color: Color(0xffFCFCF9),
            ),
            child: Column(
              children:[
                // 닫기 버튼
                GestureDetector(
                  onTap: () { // 버튼 클릭 시 이전 페이지인 요청서 확인 페이지로 이동
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MainErrandCheck(errandNo: errandNo,),
                        ),
                      );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 280.w, top: 8.h),
                    color: Colors.transparent,
                    child: Icon(
                      Icons.close,
                      color: Color(0xff8E8E8E),
                    ),
                  ),
                ),

                // 심부름 요청서 제목
                Container(
                  margin: EdgeInsets.only(top: 4.h, left: 93.w, right: 91.w),
                  child: Text(
                    "심부름 요청서",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      letterSpacing: 0.00,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                // 심부름 요청서 멘트
                /*Container(
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
                                  "사랑하는 ",
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 11,
                                    letterSpacing: 0.00,
                                    color: Color(0xff111111),
                                  ),
                              children: [
                                WidgetSpan(
                                    child: TextFieldWidget(realName: realName)
                                ),
                                TextSpan(
                                  text: " 님의 탁월함과 열정에 감사하며 아래와 같이 심부름을 요청합니다. 심부름 사항을 확인 후 완료 버튼을 통해 심부름을 확정해주시면 감사하겠습니다.",
                                ),
                              ],
                              ),
                            )
                        ),
                      ],
                    )),*/

                Container(
                    width: 217.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(
                              "사랑하는 ",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w300,
                                fontSize: 11.sp,
                                letterSpacing: 0.00,
                                color: Color(0xff111111),
                              ),
                          ),
                        ),
                        Container(
                            child: true? TextFieldWidget(realName: realName) : null ,
                        ),
                        Container(
                          child: Text(
                            " 님의 탁월함과 ",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              fontSize: 11.sp,
                              letterSpacing: 0.00,
                              color: Color(0xff111111),
                            ),
                          ),
                        ),
                      ],
                      ),
                Container(
                  width: 252.w,
                  child : Text(
                    "열정에 감사하며 아래와 같이 심부름을 요청합니다.\n"
                        "심부름 사항을 확인 후 완료 버튼을 통해 심부름을\n"
                        "확정해주시면 감사하겠습니다.",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      fontSize: 11.sp,
                      letterSpacing: 0.00,
                      color: Color(0xff111111),
                     ),
                    ),
                   ),
                  ],
                  ),
                ),
                // -아래- 텍스트
                Container(
                  margin: EdgeInsets.only(top: 11.h, left: 144.w, right: 151.w),
                  child: Text(
                    "-아래-",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      letterSpacing: 0.00,
                      color: Color(0xff000000),
                    ),
                  ),
                ),

                // 심부름 사항, 금액 및 결제
                Container(
                  width: 287.w,
                  height: 328.85.h,
                  margin: EdgeInsets.only(top: 14.h),
                  alignment: Alignment.center, // 중앙 정렬
                  decoration: BoxDecoration(
                    color: Color(0xffF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 13.65.h),
                          child: Row(
                            children: [
                              // 심부름 사항 네모 이미지
                              Container(
                                  margin: EdgeInsets.only(left: 23.5.w),
                                  child: Image.asset("assets/images/small_rectangle.png")
                              ),
                              //심부름 사항 텍스트
                              Container(
                                margin: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  "심부름 사항",
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    letterSpacing: 0.001,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 6.68.h),
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
                          margin: EdgeInsets.only(top: 7.68.h),
                          child: Row(
                            children: [
                              // 금액 및 결제 네모 이미지
                              Container(
                                  margin: EdgeInsets.only(left: 23.5.w),
                                  child: Image.asset("assets/images/small_rectangle.png")
                              ),
                              //금액 및 결제 텍스트
                              Container(
                                margin: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  "금액 및 결제",
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    letterSpacing: 0.001,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      // 금액 및 결제 표
                      Container(
                        margin: EdgeInsets.only(top: 6.h),
                        child: TableScreen2(
                          reward: reward,
                          isCash: isCash,
                        ),),
                    ],
                  ),
                ),
                // // (주) 커카글쓴이 닉네임 (서명)
                // Container(
                //   // margin: EdgeInsets.only(top: 17.15),
                //   child: Stack(
                //     children: [
                //       // Center-aligned Row
                //       Align(
                //         alignment: Alignment.center, // 가운데 정렬
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min, // 최소한의 너비 가지기
                //           children: [
                //             // (주) 커카글쓴이 -> 글 쓴 사람 -> name
                //             Container(
                //               margin: EdgeInsets.only(top: 17.15, left: 0),
                //               child: Text(
                //                 "(주) ${utf8.decode(name.runes.toList())}",
                //                 style: TextStyle(
                //                   fontFamily: 'Pretendard',
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: 11,
                //                   letterSpacing: 0.001,
                //                   color: Color(0xff000000),
                //                 ),
                //               ),
                //             ),
                //             // 닉네임 -> 글 보기 하는 사람 -> 닉네임
                //             AnimatedContainer(
                //               duration: Duration(milliseconds: 200),
                //               margin: EdgeInsets.only(top: 17.15, left: 5),
                //               child: nickName != "닉 네 임" ? FutureBuilder(
                //                 future: Future.delayed(Duration(milliseconds: 1250)),
                //                 builder: (context, snapshot) {
                //                   if (snapshot.connectionState == ConnectionState.done) {
                //                     return AnimatedTextKit(
                //                       animatedTexts: [
                //                         TyperAnimatedText(
                //                           utf8.decode(nickName.runes.toList()),
                //                           speed: Duration(milliseconds: 200),
                //                           textStyle: TextStyle(
                //                             fontFamily: 'SangSangShin',
                //                             fontWeight: FontWeight.w400,
                //                             fontSize: 15,
                //                             letterSpacing: 0.01,
                //                             color: Color(0xff000000),
                //                           ),
                //                         ),
                //                       ],
                //                       totalRepeatCount: 1,
                //                     );
                //                   } else {
                //                     return SizedBox.shrink();
                //                   }
                //                 },
                //               ):
                //                   Text("닉 네 임",
                //                 style: TextStyle(
                //                   fontFamily: 'MaruBuri',
                //                   fontWeight: FontWeight.w700,
                //                   fontSize: 12,
                //                   letterSpacing: 0.01,
                //                   color: Color(0xff000000),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                // (주) 커카글쓴이 닉네임 (서명)
                Container(
                  // margin: EdgeInsets.only(top: 17.15),
                  child: Stack(
                    children: [
                      // (주) 커카글쓴이 -> 글 쓴 사람 -> name
                      Align(
                        alignment: Alignment.centerLeft, // 왼쪽 정렬
                        child: Container(
                          margin: EdgeInsets.only(top: 17.15.h, left: 39.5.w),
                          child: Text(
                            "(주) ${utf8.decode(name.runes.toList())}",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              letterSpacing: 0.001,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                          ),

                        Align(
                          alignment: Alignment.centerLeft, // 가운데 정렬
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // 최소한의 너비 가지기
                          children: [
                            // 닉네임 -> 글 보기 하는 사람 -> 닉네임
                            AnimatedContainer(
                              duration: Duration(milliseconds: 350),
                              margin: nickName != "닉 네 임"
                              ? EdgeInsets.only(top: 14.h, left: 150.w)
                                  : EdgeInsets.only(top: 17.h, left: 150.w),
                              child: nickName != "닉 네 임" ? FutureBuilder(
                                future: Future.delayed(Duration(milliseconds: 1800)),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          utf8.decode(nickName.runes.toList()),
                                          speed: Duration(milliseconds: 200),
                                          textStyle: TextStyle(
                                            fontFamily: 'SangSangShin',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                            letterSpacing: 0.01,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                      totalRepeatCount: 1,
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ):
                                  Text("닉 네 임",
                                style: TextStyle(
                                  fontFamily: 'MaruBuri',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
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
                          margin: EdgeInsets.only(top: 17.15.h, right: 37.w),
                          child: Text(
                            "( 서 명 )",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
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
                            margin: EdgeInsets.only(top: 41.15.h, right: 37.5.w),
                            child: Image.asset("assets/images/Line1.png")
                        ),
                      ),
                      if(isStampVisible)
                      // 심부름 하는 사람(현재 로그인 한 사람) 실명 도장
                      Stamp(
                        realName: utf8.decode(realName.runes.toList()),
                      ),

                    ],
                  ),
                ),

              ],
            ),
    );
  }
}