import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/status/status_slide/status_client.dart';
import 'package:front/screens/status/status_slide/status_runner.dart';
import 'package:intl/intl.dart';

class InProgressErrandWidget extends StatelessWidget {
  final int errandNo; //게시글 번호
  final String title; //제목
  final String due; //일정
  final bool isUserOrder; //내가 요청자인지 심부름꾼인지 여부
  const InProgressErrandWidget({
    super.key,
    required this.errandNo,
    required this.title,
    required this.due,
    required this.isUserOrder,
  });
  String formatDueDate(String due) {
    // '2024-05-20 14:28:08' 형식의 문자열을 DateTime 객체로 변환합니다.
    DateTime dateTime = DateTime.parse(due);

    // 원하는 형식으로 변환합니다.
    String formattedDate = DateFormat('M월 d일 HH:mm').format(dateTime);

    String result = '일정 $formattedDate까지'; // 최종 결과 문자열

    return result;
  }
  @override
  Widget build(BuildContext context) {
    if(!isUserOrder) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent, //게시글 전체를 클릭영역으로 만들어주는 코드
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => statuspageR(errandNo: errandNo)
              ));
        },
        child:  SizedBox( width: 360.w, height: 72.51.h, //심부름 1개 수행중
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 19.14.w, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox( width: 31.w, height: 32.h,
                      child: SvgPicture.asset(
                        'assets/images/running_errand.svg', width: 30.w, height: 31.h,
                      ),
                    ), //이미지
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 14.52.w, ),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 16.sp,
                                color: const Color(0xff923D00)
                            ),
                          ),
                        ), //제목
                        Container(
                            margin: EdgeInsets.only(left: 14.52.w, ),
                            child: Text(formatDueDate(due),
                              style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400, fontSize: 13.sp,
                                  color: const Color(0xff9F9F9F)),
                            ) ), //일정
                      ],
                    ), //
                    Expanded(
                        child: Align(alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.only(right: 20.77.w, ),
                              child: Text("수행 중",
                                style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500, fontSize: 11.sp,
                                    color: const Color(0xffCFA383)),
                              )
                          ), //텍스트 수행 중/요청 중
                        )),// 텍스트(제목, 일정)
                  ],
                ),),
              Center(child: SizedBox(width: 317.66.w, child: Divider(color: const Color(0xffC8C8C8), thickness: 0.5.sp))),
            ],
          ),
        ),
      );

    }
    else
    {
      return GestureDetector(
        behavior: HitTestBehavior.translucent, //게시글 전체를 클릭영역으로 만들어주는 코드
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => statuspageQ(errandNo: errandNo)
            ),);
        },
        child:  SizedBox( width: 360.w, height: 72.51.h, //심부름 1개 요청중
          child: Column(
            children: [
              Container(margin: EdgeInsets.only(left: 19.14.w, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox( width: 31.w, height: 32.h,
                      child: SvgPicture.asset(
                        'assets/images/requesting_errand.svg', width: 30.w, height: 31.h,
                      ),
                    ), //이미지
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 14.52.w, ),
                          child: Text(title,
                            style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 16.sp,
                                color: const Color(0xff0D0D0D)),
                          ),
                        ), //제목
                        Container(
                            margin: EdgeInsets.only(left: 14.52.w),
                            child: Text(formatDueDate(due),
                              style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400, fontSize: 13.sp,
                                  color: const Color(0xff9F9F9F)),
                            ) ), //일정
                      ],
                    ), //텍스트(제목, 일정)
                    Expanded(
                        child: Align(alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.only(right: 20.77.w, ),
                              child: Text("요청 중",
                                style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500, fontSize: 11.sp,
                                    color: const Color(0xff959595)),
                              )
                          ), //텍스트 수행 중/요청 중
                        )),

                  ],
                ),),
              Center(child: SizedBox(width: 317.66.w, child: Divider(color: const Color(0xffC8C8C8), thickness: 0.5.sp))),
            ],
          ),
        ),
      );
    }
  }
}