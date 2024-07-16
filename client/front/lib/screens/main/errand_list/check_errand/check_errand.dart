import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/main/errand_list/check_errand/show_errand/show_errand.dart';
import 'package:front/widgets/button/brown_button.dart';
import 'package:front/widgets/text/button_text.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/dialog/custom_dialog.dart';
import 'fix_errand/fix_errand.dart';
import '../errand_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

final storage = FlutterSecureStorage(); // 토큰 받기

class ErrandCheckWidget extends StatelessWidget {
  final DateTime currentTime = DateTime.now();

  final int orderNo; //요청자 번호
  final String nickname; //닉네임
  final double score; //평점
  final int errandNo; //게시글 번호
  final String createdDate; //요청서 생성 시간
  final String title; //제목
  final String destination; //도착지
  final double latitude; // 위도
  final double longitude; // 경도
  final String due; // 일정 시간
  final String detail; // 요청사항
  final int reward; //심부름 값
  final bool isCash; // 계좌이체, 현금
  final String status; //상태 (모집중, 진행중, 완료됨)
  final bool isMyErrand; // 내가 작성자인지
  ErrandCheckWidget({
    Key? key,
    required this.orderNo,
    required this.nickname,
    required this.score,
    required this.errandNo,
    required this.createdDate,
    required this.title,
    required this.destination,
    required this.latitude,
    required this.longitude,
    required this.due,
    required this.detail,
    required this.reward,
    required this.isCash,
    required this.status,
    required this.isMyErrand,
  }) : super(key: key);

  late int titleLength = title.length;

  //상태에 따라 텍스트 출력
  String getState() {
    if(status == "RECRUITING")
    {
      return "모집중";
    }
    else if(status == "IN_PROGRESS")
      return "진행중";
    else if(status == "DONE")
      return "완료됨";
    else
    {
      return "";
    }
  }
  // 상태 박스 색상
  Color decideBoxColor(String state){
    Color stateColor;
    if(state == "RECRUITING")
    {
      stateColor = Color(0xffFFFFFF);
      return stateColor;
    }
    else if(state == "IN_PROGRESS")
    {
      stateColor = Color(0xffAA7651);
      return stateColor;
    }
    else if(state == "DONE")
    {
      stateColor = Color(0xffCCB9AB);
      return stateColor;
    }
    else
    {
      stateColor = Color(0xffCCB9AB);
      return stateColor;
    }
  }
  // 상태 박스 텍스트 색상
  Color decideTextColor(String state){
    Color stateColor;
    if(state == "RECRUITING")
    {
      stateColor = Color(0xffAA7651);
      return stateColor;
    }
    else if(state == "IN_PROGRESS" || state == "DONE")
    {
      stateColor = Color(0xffFFFFFF);
      return stateColor;
    }
    else
    {
      stateColor = Color(0xffFFFFFF);
      return stateColor;
    }
  }
  // 상태에 따라 테두리 변경
  Color decideBorder(String state){
    Color stateColor;
    if(state == "RECRUITING")
    {
      stateColor = Color(0xffAA7651);
      return stateColor;
    }
    else
    {
      stateColor = Colors.transparent;
      return stateColor;
    }
  }

  // 현재 시간과 게시글 작성 시간의 차 계산
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

  // 일정 형식
  late DateTime dueDateTime = DateFormat('yyyy-MM-dd HH:mm').parse(due); // 요청일 String을 DateTime으로 변환
  // 날짜를 yyyy.MM.dd  hh:mm 형식으로 변환하는 함수
  String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}  ${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}';
  }

  // 글보기 상세 페이지
  @override
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat('###,###,###,###');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(isMyErrand == false) // 내가 쓴 게시글이 아니면 닉네임, 평점 생성
                //닉네임, 평점
                Container(
                    margin: EdgeInsets.only(top: 16.4.h),
                    child: Row(
                  children: [
                    //닉네임
                    Container(
                      margin: EdgeInsets.only(left: 13.59.w),
                      child: Text(
                        "${nickname}",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w300,
                          fontSize: 14.sp,
                          letterSpacing: 0.001,
                          color: Color(0xff575757),
                        ),
                      ),
                    ),
                    // 평점 커카 이미지
                    Container(
                      margin: EdgeInsets.only(left: 9.1.w),
                      child: SvgPicture.asset(
                        'assets/images/score_icon.svg',
                        // Replace with your image asset path
                        width: 11.77.w, // Adjust the size as needed
                        height: 11.77.h, // Adjust the size as needed
                        color: Color(0xffCFB6A5),
                      ),
                    ),
                    //평점
                    Container(
                      margin: EdgeInsets.only(left: 2.82.w),
                      child: Text(
                        " ${score.toInt()}점",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w300,
                          fontSize: 13.sp,
                          letterSpacing: -0.03,
                          color: Color(0xffCFB6A5),
                        ),
                      ),
                    ),
                    // 현황
                    Expanded(
                        child: Align(alignment: Alignment.centerRight,
                        child: Container(
                      margin: EdgeInsets.only(right: 19.92.w),
                      width: 44.36.w, height: 18.1.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: decideBoxColor(status),
                        border: Border.all(color: decideBorder(status),width: 1),
                      ),
                      child: Center( //상태
                        child: Text(getState(), style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            letterSpacing: 0.01,
                            color: decideTextColor(status),
                        ),),
                      ),
                    ),
                    )
                    )
                  ],
                )),
                // 내가 작성한 심부름
                if(isMyErrand == true)
                //게시글 제목
                Container(
                  margin: EdgeInsets.only(top: 18.77.h, left: 13.4.w, right: 18.6.w),
                  child: Text(
                    "${title}",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      letterSpacing: 0.001,
                      color: Color(0xff111111),
                    ),
                  ),
                ),
                // 내가 작성한 심부름 x
                if (isMyErrand == false)
                //게시글 제목
                  Container(
                    margin: EdgeInsets.only(top: 10.59.h, left: 13.4.w, right: 18.6.w),
                    child: Text(
                      "${title}",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        letterSpacing: 0.001,
                        color: Color(0xff111111),
                      ),
                    ),
                  ),
                // 내가 작성한 심부름
                if (isMyErrand == true)
                // 심부름 값
                Container(
                  margin: EdgeInsets.only(top: 3.h, left: 13.4.w),
                  child: Text(
                    "\u20A9 ${priceFormat.format(reward)} 원",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      letterSpacing: 0.001,
                      color: Color(0xff7C3D1A),
                    ),
                  ),
                ),
                // 내가 작성한 심부름 x
                if (isMyErrand == false)
                // 심부름 값
                  Container(
                    margin: EdgeInsets.only(top: 6.h, left: 13.4.w),
                    child: Text(
                      "\u20A9 ${priceFormat.format(reward)} 원",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        letterSpacing: 0.001,
                        color: Color(0xff7C3D1A),
                      ),
                    ),
                  ),
                // 상세 주소
                Container(
                    margin: EdgeInsets.only(top: 18.h),
                    child: Row(
                      children: [
                        // 마커 이미지
                        Container(
                          margin: EdgeInsets.only(left: 18.97.w),
                          child: SvgPicture.asset(
                            'assets/images/marker_small.svg',
                            // Replace with your image asset path
                            width: 12.2.w, // Adjust the size as needed
                            height: 16.77.h, // Adjust the size as needed
                          ),
                        ),
                        // 상세 주소 텍스트
                        Container(
                          margin: EdgeInsets.only(left: 7.67.w),
                          child: Text(
                            "상세 주소",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              letterSpacing: 0.001,
                              color: Color(0xffBC9F9F),
                            ),
                          ),
                        ),
                        // 상세 주소 정보
                        Container(
                          margin: EdgeInsets.only(left: 7.w),
                          child: Text(
                            "${destination}",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              letterSpacing: 0.001,
                              color: Color(0xff505050),
                            ),
                          ),
                        ),
                      ],
                    )),

                Container(
                    margin: EdgeInsets.only(top: 8.28.h),
                    child: Row(
                      children: [
                        // 시계 이미지
                        Container(
                          margin: EdgeInsets.only(left: 18.53.w),
                          child: SvgPicture.asset(
                            'assets/images/clock.svg',
                            width: 14.w, // Adjust the size as needed
                            height: 14.h, // Adjust the size as needed
                          ),
                        ),
                        // 일정 텍스트
                        Container(
                          margin: EdgeInsets.only(left: 6.23.w),
                          child: Text(
                            "일정",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              letterSpacing: 0.001,
                              color: Color(0xffBC9F9F),
                            ),
                          ),
                        ),
                        // 일정
                        Container(
                          margin: EdgeInsets.only(left: 6.w),
                          child: Text(
                            "${formatDate(dueDateTime)} 까지",
                            // "${due}까지",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              letterSpacing: 0.001,
                              color: Color(0xff505050),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(alignment: Alignment.centerRight,
                          child: Container(
                          //게시글 올린 시간으로부터 현재까지 지난 시간
                          margin: EdgeInsets.only(right: 18.6.w),
                          child: Text(
                            timeDifference(currentTime, createdDate),
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                letterSpacing: 0.001,
                                color: Color(0xff434343)),
                          ),
                        ),
                        ),
                        ),
                      ],
                    )),
                // 내가 작성한 심부름
                if (isMyErrand == true)
                // 실선
                Container(
                  margin: EdgeInsets.only(top: 16.49.h, left: 12.01.w, right: 9.99.w),
                  height: 1.0.h,
                  width: 298.w,
                  color: Color(0xffDBDBDB),
                ),
                // 내가 작성한 심부름 x
                if (isMyErrand == false)
                // 실선
                  Container(
                    margin: EdgeInsets.only(top: 12.h, left: 12.01.w, right: 9.99.w),
                    height: 1.0.h,
                    width: 298.w,
                    color: Color(0xffDBDBDB),
                  ),
                // 요청 사항
                  Container(
                    margin: EdgeInsets.only(top: 12.h, left: 20.66.w, right: 19.34.w),
                    child:  Text(
                      "${detail}",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        letterSpacing: 0.001,
                        color: Color(0xff111111),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// order 구조체
class order {
  int orderNo;
  String nickname; // 닉네임
  double score; // 평점
  order(this.orderNo, this.nickname, this.score);

  factory order.fromJson(Map<String, dynamic> json) {
    return order(
      json['orderNo'],
      json['nickname'],
      json['score'],
    );
  }
}

// Errand 구조체
class Errand {
  // 게시글에 담긴 정보들
  order o1;
  int errandNo; //게시글 번호
  String createdDate; //생성된 날짜
  String title; //게시글 제목
  String destination; //위치
  double latitude; // 위도
  double longitude; // 경도
  String due; // 일정 시간
  String detail; // 상세정보
  int reward; // 심부름 값
  bool isCash; // 계좌이체, 현금
  String status; //상태 (모집중 or 진행중 or 완료됨)
  bool isMyErrand; // 내 요청서인지 아닌지 확인
  Errand(
      this.o1,
      this.errandNo,
      this.createdDate,
      this.title,
      this.destination,
      this.latitude,
      this.longitude,
      this.due,
      this.detail,
      this.reward,
      this.isCash,
      this.status,
      this.isMyErrand);

  factory Errand.fromJson(Map<String, dynamic> json) {
    return Errand(
      order.fromJson(json['order']),
      json['errandNo'],
      json['createdDate'],
      json['title'],
      json['destination'],
      json['latitude'],
      json['longitude'],
      json['due'],
      json['detail'],
      json['reward'],
      json['isCash'],
      json['status'],
      json['isMyErrand'],
    );
  }
}

// Error 구조체
class Error {
  String code;
  var httpStatus;
  String message;

  Error(this.code, this.httpStatus, this.message);

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}

class MainErrandCheck extends StatefulWidget {
  final int errandNo;

  MainErrandCheck({Key? key, required this.errandNo}) : super(key: key);

  @override
  State createState() => _MainErrandCheckState();
}

class _MainErrandCheckState extends State<MainErrandCheck> {
  List<Map<String, dynamic>> errands = [];
  String? token = "";
  late int errandNo;

  late double latitude = 0;
  late double longitude = 0;
  late NLatLng myLatLng;
  late NMarker marker;

  NOverlayImage destIcon = NOverlayImage.fromAssetImage(
      "assets/images/map_dest.png");

  Future<void> errandReading(String id) async {
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/$id";
    print(url + param);

    token = await storage.read(key: 'TOKEN');
    var response = await http
        .get(Uri.parse(url + param), headers: {"Authorization": "$token"});

    if (response.statusCode == 200) {
      Errand errand = Errand.fromJson(jsonDecode(response.body));
      log("due : ${errand.due}");
      errands.add({
        "orderNo": errand.o1.orderNo,
        "nickname": errand.o1.nickname,
        "score": errand.o1.score,
        "errandNo": errand.errandNo,
        "createdDate": errand.createdDate,
        "title": errand.title,
        "destination": errand.destination,
        "latitude": errand.latitude,
        "longitude": errand.longitude,
        "due": errand.due,
        "detail": errand.detail,
        "reward": errand.reward,
        "isCash": errand.isCash,
        "status": errand.status,
        "isMyErrand": errand.isMyErrand,
      });
      log("status code == 200, Json Data Parsed.");
      setState(() {
        latitude = errand.latitude;
        longitude = errand.longitude;
        myLatLng = NLatLng(latitude, longitude); // 백엔드에서 값 받아오기
        marker = NMarker(
          id: "도착지",
          position: myLatLng,
        );
        marker.setIcon(destIcon);
        // DB에 저장된 위도, 경도
        log("latitude : $latitude");
        log("longitude : $longitude");
      });
    } else {
      warningDialog(context, "서버에 문제가 있어요!");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      print(error.code);
      print(error.httpStatus);
      print(error.message);
    }
  }

  Future<void> deleteErrand() async {
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/$errandNo";
    print(url + param);

    token = await storage.read(key: 'TOKEN');
    var response = await http
        .delete(Uri.parse(url + param), headers: {"Authorization": "$token"});

    if (response.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
      );
    }
    else {
      print(response.body);
    }
  }

  // 수정하기 버튼
  void pressedFix(BuildContext context) {
    if(errands[0]['status'] == "RECRUITING") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              FixErrand(errands: errands[0]),
        ),
      );
    }
    else {
      // 수정하기 버튼 클릭
      warningDialog(context, "수락된 요청은 수정할 수 없어요!");
    }
  }

  // 삭제하기 버튼
  void pressedDelete(BuildContext context) {
    if(errands[0]['status'] == "RECRUITING") {
      deleteDialog(context);
    }
    else {
      deleteErrorDialog(context);
    }
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: 323.w,
            height: 268.29.h,
            decoration: BoxDecoration(
            color: Color(0xffFFFFFF), //배경색
            borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
        children: <Widget>[
          Container(
          margin: EdgeInsets.only(top: 24.h),
                child: Icon(
                  Icons.delete,
                  color: Color(0xffA98474),
                  size: 60.sp,
                ),
          ),
                Container(
                  margin: EdgeInsets.only(top: 12.h),
                child: Text(
                  "정말 삭제하시겠어요?",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.04,
                    color: Color(0xff1A1A1A),
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
               Container(
                 margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  "삭제 버튼 선택 시, 심부름은\n삭제되며 복구되지 않아요!",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: Color(0xff9B7D68),
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
                Container(
                  margin: EdgeInsets.only(top: 18.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16.w),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(134.18.w, 45.h)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // 원하는 모양에 따라 BorderRadius 조절
                            ),
                          ),
                        ),
                        child: Text(
                          "삭제",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            letterSpacing: 0.00,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                        onPressed: () {
                          deleteErrand();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.w),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffFFFFFF)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(134.18.w, 45.h)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Color(0xff999999), // 테두리 색상
                                width: 1 // 테두리 두께
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          "취소",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            letterSpacing: 0.00,
                            color: Color(0xff3E3E3E),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                      ],
                     ),
                    ),
                  ],
                ),
              ),
           ),
        );
      },
    );
  }

  void deleteErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              // padding: EdgeInsets.all(20),
              width: 323.w,
              height: 214.h,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.04.h),
                    child: SvgPicture.asset(
                      'assets/images/alert.svg',
                      width: 76.83.w,
                      height: 76.83.h,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.08.h),
                    child: Text(
                      "수락된 요청은 삭제할 수 없어요!",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        letterSpacing: 0.00,
                        color: Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17.77.h),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(281.1.w, 47.25.h)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // 원하는 모양에 따라 BorderRadius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          letterSpacing: 0.00,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    errandNo = widget.errandNo;
    errandReading(errandNo.toString()).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // 메인 글 보기 화면
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    Home()
            )
        );
      },
      child: Scaffold(
        body: _isLoading ? Center(child: CircularProgressIndicator()) :
        Stack(
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
                        // 네이버 지도
                        Container(
                          // margin: EdgeInsets.only(left: 19, top: 50),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 320.w,
                                height: 212.h,
                                margin: EdgeInsets.only(left: 19.w, top: 50.h),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Color(0xffC6C6C6), width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Color(0xffFFFFFF),
                                      ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                  child: NaverMap(
                                    options: NaverMapViewOptions(
                                      logoClickEnable: false, // 네이버 로고 클릭 비활성화

                                      mapType: NMapType.basic, // 지도 유형 : 기본 지도(기본 값)
                                      activeLayerGroups: [ // 표시할 정보
                                        NLayerGroup.building, // 건물 레이어
                                        NLayerGroup.transit, // 대중교통 레이어
                                      ],
                                      // 제스처의 마찰계수 지정(0.0~1.0 -> 0: 미끄러움)
                                      scrollGesturesFriction: 0.5, // 스크롤
                                      zoomGesturesFriction: 0.5, // 줌

                                      initialCameraPosition: NCameraPosition(
                                          target: NLatLng(latitude, longitude), // 내 위치
                                          // 위도, 경도
                                          // 부경대 대연캠퍼스
                                          // 위도 latitude : 35.134384930841364
                                          // 경도 longitude : 129.10592409493796
                                          zoom: 14.5, // 지도의 초기 줌 레벨
                                          bearing: 0, // 지도의 회전 각도(0 : 북쪽이 위)
                                          tilt: 0 // 지도의 기울기 각도(0 : 평면으로 보임)
                                      ),
                                    ),

                                    onMapReady: (controller) {
                                      controller.addOverlay(marker);
                                      print("네이버 맵 로딩됨!");
                                    },

                                    forceGesture: true,
                                    // SingleChildScrollView 안에서 사용하므로, NaverMap에
                                    // 전달되는 제스처 무시 현상 방지 위함
                                  ),
                                  ),
                                ),
                                    // 검색 아이콘
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () { // 버튼 클릭 시 이전 페이지인 게시글 페이지로 이동
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Home()
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 30.w, bottom: 100.h),
                                      color: Colors.transparent,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Color(0xff6B6B6B),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                    ],
                        ),
                    ),

                    // 글 보기 하는 사람
                    if (errands[0]["isMyErrand"] == false)
                    Flexible(
                      child: Container(
                        width: 320.w,
                        height: 305.85.h,
                        //게시글 큰틀
                        margin: EdgeInsets.only(left: 18.w, top: 15.51.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffFFFFFF),
                        ),
                            child: Column(
                              children: errands.map((errand) {
                                String nickname = errand["nickname"];
                                String createdDate = errand["createdDate"];
                                String title = errand['title'];
                                String destination = errand['destination'];
                                String due = errand['due'];
                                String detail = errand['detail'];
                                String status = errand['status'];

                                String decodedNickname = utf8.decode(nickname.runes.toList());
                                String decodedCreatedDate = utf8.decode(createdDate.runes.toList());
                                String decodedTitle = utf8.decode(title.runes.toList());
                                String decodedDestination = utf8.decode(destination.runes.toList());
                                String decodedDue = utf8.decode(due.runes.toList());
                                String decodedDetail = utf8.decode(detail.runes.toList());
                                String decodedStatus = utf8.decode(status.runes.toList());

                                return ErrandCheckWidget(
                                  orderNo: errand["orderNo"],
                                  nickname: decodedNickname,
                                  score: errand["score"],
                                  errandNo: errand["errandNo"],
                                  createdDate: decodedCreatedDate,
                                  title: decodedTitle,
                                  destination: decodedDestination,
                                  latitude: errand["latitude"],
                                  longitude: errand["longitude"],
                                  due: decodedDue,
                                  detail: decodedDetail,
                                  reward: errand["reward"],
                                  isCash: errand["isCash"],
                                  status: decodedStatus,
                                  isMyErrand: errand["isMyErrand"],
                                );
                              }).toList(),
                            ),
                          ),
                      ),
                    // 글 보기 올린 사람
                    if (errands[0]["isMyErrand"] == true)
                      Flexible(
                        child: Container(
                          width: 320.w,
                          height: 274.98.h,
                          //게시글 큰틀
                          margin: EdgeInsets.only(left: 19.01.w, top: 18.73.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffFFFFFF),
                          ),
                            child: Column(
                              children: errands.map((errand) {
                                String nickname = errand["nickname"];
                                String createdDate = errand["createdDate"];
                                String title = errand['title'];
                                String destination = errand['destination'];
                                String due = errand['due'];
                                String detail = errand['detail'];
                                String status = errand['status'];

                                String decodedNickname = utf8.decode(nickname.runes.toList());
                                String decodedCreatedDate = utf8.decode(createdDate.runes.toList());
                                String decodedTitle = utf8.decode(title.runes.toList());
                                String decodedDestination = utf8.decode(destination.runes.toList());
                                String decodedDue = utf8.decode(due.runes.toList());
                                String decodedDetail = utf8.decode(detail.runes.toList());
                                String decodedStatus = utf8.decode(status.runes.toList());

                                return ErrandCheckWidget(
                                  orderNo: errand["orderNo"],
                                  nickname: decodedNickname,
                                  score: errand["score"],
                                  errandNo: errand["errandNo"],
                                  createdDate: decodedCreatedDate,
                                  title: decodedTitle,
                                  destination: decodedDestination,
                                  latitude: errand["latitude"],
                                  longitude: errand["longitude"],
                                  due: decodedDue,
                                  detail: decodedDetail,
                                  reward: errand["reward"],
                                  isCash: errand["isCash"],
                                  status: decodedStatus,
                                  isMyErrand: errand["isMyErrand"],
                                );
                              }).toList(),
                            ),
                            ),
                        ),

                    if (errands[0]["isMyErrand"] == false && errands[0]["status"] == "RECRUITING")
                    // 제가 할게요! 버튼(글 보기 하는 사람)
                    Container(
                      margin: EdgeInsets.only(left: 21.w, right: 21.w, top: 13.32.h),
                      child: ElevatedButton(
                        onPressed: () async{
                          print("제가 할게요! 클릭");
                          // 심부름 요청서 팝업 느낌으로 띄우기
                          String updatedStatus =
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainShowErrand(errands : errands[0]),
                            ),
                          );
                        },
                        style: brownButton318(Color(0xFF7C3D1A)),
                        child: buttonText("제가 할게요!"),
                      ),
                    ),
                    if (errands[0]["isMyErrand"] == true)
                    // 수정하기, 삭제하기 버튼(글 보기 올린 사람)
                    Container(
                      margin: EdgeInsets.only(top: 13.38.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 18.w),
                              decoration: BoxDecoration(
                                // 2px 3px 4px rgba(161, 161, 161, 0.25);
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(161, 161, 161, 0.25),
                                    offset: Offset(2, 3),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  print("수정하기 버튼 클릭!");
                                  pressedFix(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xffFFFFFF)),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(151.73.w, 49.7.h)),
                                  // 버튼의 모양 변경하기
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        // 원하는 모양에 따라 BorderRadius 조절
                                        side: BorderSide(
                                          color: Color(0xff9B9B9B),
                                          width: 1,
                                        )),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min, // 중앙 정렬
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/pencil.svg',
                                      // Replace with your image asset path
                                      width: 19.12.w,
                                      height: 19.12.h,
                                      color: Color(0xff7F7F7F),
                                    ),
                                    SizedBox(width: 6.55.w),
                                    // Adjust the space between icon and text as needed
                                    Text(
                                      '수정하기',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF545454),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 17.55.w, right: 20.99.w),
                            decoration: BoxDecoration(
                              // 2px 3px 4px rgba(161, 161, 161, 0.25);
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(161, 161, 161, 0.25),
                                  offset: Offset(2, 3),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                pressedDelete(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xffFFFFFF)),
                                // 버튼의 크기 정하기
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(151.73.w, 49.7.h)),
                                // 버튼의 모양 변경하기
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      // 원하는 모양에 따라 BorderRadius 조절
                                      side: BorderSide(
                                        color: Color(0xffFF6767),
                                        width: 1.w,
                                      )),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bin.svg',
                                    // Replace with your image asset path
                                    width: 17.35.w, // Adjust the size as needed
                                    height: 21.11.h, // Adjust the size as needed
                                  ),
                                  SizedBox(width: 8.3.w),
                                  // Adjust the space between icon and text as needed
                                  Text(
                                    '삭제하기',
                                    style: TextStyle(
                                      fontSize: 15.sp,
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
          ],
        ),
      ),
    );
  }
}
