import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text/post_price_text.dart';
import 'text/post_small_gray.dart';
import 'text/post_title_text.dart';

class HistoryWidget extends StatelessWidget {
  final int orderNo; //상대방 번호
  final String nickname; //닉네임
  final double score; //평점
  final int errandNo; //게시글 번호
  final String createdDate; //생성시간
  final String title; //제목
  final int reward; //보수
  //목적지는 표시 안함
  //상태는 완료됨 고정
  const HistoryWidget({
    super.key,
    required this.orderNo,
    required this.nickname,
    required this.score,
    required this.errandNo,
    required this.createdDate,
    required this.title,
    required this.reward});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 314.w,
            height: 77.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row( //닉네임, 평점
                    children: [
                      Container( //닉네임
                        margin: EdgeInsets.only(
                          left: 15.w,
                          top: 16.h,
                        ),
                        child: smallGrayText(nickname),
                      ),
                      Container( //평점
                        margin: EdgeInsets.only(top: 16.h, ),
                        child: smallGrayText(" ${score.toInt()}점"),
                      )
                    ],
                  ),
                  Container( //게시글 제목
                    margin: EdgeInsets.only(
                      top: 8.h,
                      left: 15.w,
                    ),
                    child: titleText(title),
                  ),
                  Row( //위치, 가격
                    children: [
                      Container( margin: EdgeInsets.only(top: 10.h, ),
                        child: priceText(reward),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 11.w,
                          top: 8.95.h,
                        ),
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        width: 44.36.w,
                        height: 18.1.h,
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
                    ],
                  ),
              ]
            )
          )
        ]
    );
  }
}
