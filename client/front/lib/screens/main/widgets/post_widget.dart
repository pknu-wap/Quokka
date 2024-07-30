import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/main/widgets/text/post_price_text.dart';
import 'package:front/screens/main/widgets/text/post_small_gray.dart';
import 'package:intl/intl.dart';

import 'text/post_title_text.dart';

class PostWidget extends StatelessWidget {
  final DateTime currentTime = DateTime.now();
  final int orderNo; //요청자 번호
  final String nickname; //닉네임
  final double score; //평점
  final int errandNo; //게시글 번호
  final String createdDate; //생성시간
  final double distance; //목적지 거리
  final String title; //제목
  final String destination; //목적지
  final int reward; //보수
  final String status; //상태 (모집중, 진행중, 완료됨)
  PostWidget({
    super.key,
    required this.orderNo,
    required this.nickname,
    required this.score,
    required this.errandNo,
    required this.createdDate,
    required this.distance,
    required this.title,
    required this.destination,
    required this.reward,
    required this.status,
  });
  String timeDifference(DateTime currentTime, String createdDate) {
    DateTime createdDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(createdDate);
    Duration difference = currentTime.difference(createdDateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
  String distanceFunction(double distance) {
    if (distance < 1) {
      return '${(distance * 1000).toStringAsFixed(0)} m';
    }
    else {
      return '${distance.toStringAsFixed(1)} km';
    }
  }
  String getState() { //상태에 따라 텍스트 출력
    if(status == "RECRUITING")
    {
      return "모집중";
    }
    else if(status == "IN_PROGRESS")
    {
        return "진행중";
    }
    else if(status == "DONE")
    {
      return "완료됨";
    }
    else
    {
      return "";
    }
  }
  Color decideBoxColor(String state){
    Color stateColor;
    if(state == "RECRUITING")
    {
      stateColor = const Color(0xffFFFFFF);
      return stateColor;
    }
    else if(state == "IN_PROGRESS")
    {
      stateColor = const Color(0xffAA7651);
      return stateColor;
    }
    else if(state == "DONE")
    {
      stateColor = const Color(0xffCCB9AB);
      return stateColor;
    }
    else
    {
      stateColor = const Color(0xffCCB9AB);
      return stateColor;
    }
  }
  Color decideTextColor(String state){
    Color stateColor;
    if(state == "RECRUITING")
    {
      stateColor = const Color(0xffAA7651);
      return stateColor;
    }
    else if(state == "IN_PROGRESS" || state == "DONE")
    {
      stateColor = const Color(0xffFFFFFF);
      return stateColor;
    }
    else
    {
      stateColor = const Color(0xffFFFFFF);
      return stateColor;
    }
  }
  Color decideBorder(String state){
    Color stateColor;
    if(state == "RECRUITING")
    {
      stateColor = const Color(0xffAA7651);
      return stateColor;
    }
    else
    {
      stateColor = Colors.transparent;
      return stateColor;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox( width: 322.w,
          height: 103.h, //게시글 1개
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
                  Container( margin: EdgeInsets.only(
                    left: 15.w,
                    top: 10.h,
                  ),
                    child: Text("$destination   ", style: TextStyle(
                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500, fontSize: 13.sp,
                      letterSpacing: 0.01, color: const Color(0xff000000),
                    ),),),
                  Container( margin: EdgeInsets.only(top: 10.h, ),
                    child: priceText(reward)),
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
                      color: decideBoxColor(status),
                      border: Border.all(color: decideBorder(status),width: 1.w),
                    ),
                    child: Center( //상태
                      child: Text(getState(), style: TextStyle(
                          fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500, fontSize: 11.sp,
                          letterSpacing: 0.01, color: decideTextColor(status)
                      ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(alignment: Alignment.centerRight,
                          child: Container( //시간
                            margin: EdgeInsets.only(
                              right: 14.w,
                              top: 17.95.h,
                            ),
                            child: Text(distance == -1.0 ? timeDifference(currentTime, createdDate) : distanceFunction(distance),
                              style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400, fontSize: 12.sp,
                                  letterSpacing: 0.001, color: const Color(0xff434343)),
                            ),
                          )
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(child: SizedBox(width: 312.w, child: Divider(color: const Color(0xffDBDBDB), thickness: 0.5.sp))),
      ],
    );
  }
}