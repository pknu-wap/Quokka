import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'text/post_date_text.dart';
import 'text/post_price_text.dart';
import 'text/post_small_gray.dart';
import 'text/post_title_text.dart';

class HistoryWidget extends StatelessWidget {
  final int orderNo; // 상대방 번호
  final String nickname; // 닉네임
  final double score; // 평점
  final int errandNo; // 게시글 번호
  final String errandDate; // 게시물 날짜
  final String title; // 제목
  final int reward; // 보수

  const HistoryWidget({
    super.key,
    required this.orderNo,
    required this.nickname,
    required this.score,
    required this.errandNo,
    required this.errandDate,
    required this.title,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314.w,
      height: 101.h,
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 23.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          width: 1.w,
          color: const Color(0xff9C9C9C),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.32.h, left: 14.w),
            child: SvgPicture.asset(
              'assets/images/Avatar.svg',
              width: 60.w,
              height: 63.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container( //닉네임
                      margin: EdgeInsets.only(
                        left: 20.w,
                        top: 9.h,
                      ),
                      child: smallGrayText(nickname),
                    ),
                    Container( //평점
                      margin: EdgeInsets.only(top: 9.h, ),
                      child: smallGrayText(" ${score.toInt()}점"),
                    )
                  ],
                ),
                Container( //게시글 제목
                  margin: EdgeInsets.only(
                    top: 9.h,
                    left: 18.w,
                  ),
                  child: titleText(title),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 9.h, left: 18.w,),
                      child: priceText(reward),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 11.h, left: 8.w,),
                      child: dateText(errandDate),
                    ),
             Expanded(
          child: Align(
    alignment: Alignment.centerRight,
    child:
                    Container(
                      margin: EdgeInsets.only( right: 13.64.w,
                        top: 11.h,),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      width: 44.36.w,
                      height: 16.99.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        color: const Color(0xffAA7651),
                        border: Border.all(color: Colors.transparent,width: 1.w),
                      ),
                      child: Center( //상태
                        child: Text("완료됨", style: TextStyle(
                            fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500, fontSize: 11.sp,
                            letterSpacing: 0.01, color: const Color(0xffFFFFFF)
                          ),
                        ),
                      ),
                    ),
                   ),
                  ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }
