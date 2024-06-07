import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:front/status_page_running.dart';
import 'package:front/writeerrand.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'checkerrand.dart';
import 'login.dart';
import 'status_page_requesting.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
final storage = FlutterSecureStorage();
OverlayEntry? overlayEntry;

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
    Key? key,
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
  }) : super(key: key);
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
      return "진행중";
    else if(status == "DONE")
      return "완료됨";
    else
      {
        return "";
      }
  }
  Color decide_box_color(String state){
    Color state_color;
    if(state == "RECRUITING")
    {
      state_color = Color(0xffFFFFFF);
      return state_color;
    }
    else if(state == "IN_PROGRESS")
    {
      state_color = Color(0xffAA7651);
      return state_color;
    }
    else if(state == "DONE")
    {
      state_color = Color(0xffCCB9AB);
      return state_color;
    }
    else
    {
        state_color = Color(0xffCCB9AB);
        return state_color;
    }
  }
  Color decide_text_color(String state){
    Color state_color;
    if(state == "RECRUITING")
    {
      state_color = Color(0xffAA7651);
      return state_color;
    }
    else if(state == "IN_PROGRESS" || state == "DONE")
    {
      state_color = Color(0xffFFFFFF);
      return state_color;
    }
    else
    {
      state_color = Color(0xffFFFFFF);
      return state_color;
    }
  }
  Color decide_border(String state){
    Color state_color;
    if(state == "RECRUITING")
    {
      state_color = Color(0xffAA7651);
      return state_color;
    }
    else
    {
      state_color = Colors.transparent;
      return state_color;
    }
  }
  @override
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat('###,###,###,###');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( width: 322.w,
            height: 100.h, //게시글 1개
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                        child: Row( //닉네임, 평점
                          children: [
                            Container( //닉네임
                              margin: EdgeInsets.only(
                                  left: 15.w,
                                  top: 16.h,
                              ),
                              child: Text("${nickname}", style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300, fontSize: 12.sp,
                                letterSpacing: 0.01, color: Color(0xff7E7E7E),
                              ),),
                            ),
                            Container( //평점
                              margin: EdgeInsets.only(top: 16.h, ),
                              child: Text(" ${score.toInt()}점", style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300, fontSize: 12.sp,
                                letterSpacing: 0.01, color: Color(0xff7E7E7E),
                              ),),
                            )
                          ],
                        )
                    ),
                    Container( //게시글 제목
                      margin: EdgeInsets.only(
                        top: 8.h,
                        left: 15.w,
                      ),
                      child: Text("${title}", style: TextStyle(
                        fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600, fontSize: 16.sp,
                        letterSpacing: 0.01, color: Color(0xff111111),
                      ),),
                    ),
                    Container(
                        child: Row( //위치, 가격
                          children: [
                            Container( margin: EdgeInsets.only(
                                left: 15.w,
                                top: 10.h,
                            ),
                              child: Text("${destination}   ", style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 13.sp,
                                letterSpacing: 0.01, color: Color(0xff000000),
                              ),),),
                            Container( margin: EdgeInsets.only(top: 10.h, ),
                              child: Text("\u20A9${priceFormat.format(reward)}", style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 13.sp,
                                letterSpacing: 0.01, color: Color(0xffEC5147),
                              ),),),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 11.w,
                                  top: 8.95.h,
                           ),
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              width: 44.36.w,
                              height: 18.1.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                color: decide_box_color(status),
                                border: Border.all(color: decide_border(status),width: 1.w),
                              ),
                              child: Center( //상태
                                child: Text(getState(), style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500, fontSize: 11.sp,
                                    letterSpacing: 0.01, color: decide_text_color(status)
                                ),),
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
                                            letterSpacing: 0.001, color: Color(0xff434343)),
                                      ),))),
                          ],)),
                  ],
                ),

          ),
          Container(child: Center(child: Container(width: 312.w, child: Divider(color: Color(0xffDBDBDB), thickness: 0.5.sp)))),
        ],
      ),

    );


  }
}
class InProgress_Errand_Widget extends StatelessWidget {
  final int errandNo; //게시글 번호
  final String title; //제목
  final String due; //일정
  final bool isUserOrder; //내가 요청자인지 심부름꾼인지 여부
  InProgress_Errand_Widget({
    Key? key,
    required this.errandNo,
    required this.title,
    required this.due,
    required this.isUserOrder,
  }) : super(key: key);
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
        child:  Container( width: 360.w, height: 72.51.h, //심부름 1개 수행중
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 19.14.w, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container( width: 32.w, height: 31.h,
                      child: SvgPicture.asset(
                          'assets/images/running_errand.svg', width: 32.w, height: 31.h, fit: BoxFit.cover
                      ),
                    ), //이미지
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.52.w, ),
                            child: Text("${title}",
                              style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500, fontSize: 16.sp,
                                  color: Color(0xff923D00)),
                            ),
                          ), //제목
                          Container(
                              margin: EdgeInsets.only(left: 14.52.w, ),
                              child: Text(formatDueDate(due),
                                style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400, fontSize: 13.sp,
                                    color: Color(0xff9F9F9F)),
                              ) ), //일정
                        ],
                      ),
                    ), //
                    Expanded(
                        child: Align(alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.only(right: 20.77.w, ),
                              child: Text("수행 중",
                                style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500, fontSize: 11.sp,
                                    color: Color(0xffCFA383)),
                              )
                          ), //텍스트 수행 중/요청 중
                        )),// 텍스트(제목, 일정)
                  ],
                ),),
              Container(child: Center(child: Container(width: 317.66.w, child: Divider(color: Color(0xffC8C8C8), thickness: 0.5.sp)))),
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
        child:  Container( width: 360.w, height: 72.51.h, //심부름 1개 요청중
          child: Column(
            children: [
              Container(margin: EdgeInsets.only(left: 19.14.w, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container( width: 32.w, height: 31.h,
                      child: SvgPicture.asset(
                          'assets/images/requesting_errand.svg', width: 32.w, height: 31.h, fit: BoxFit.cover
                      ),
                    ), //이미지
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.52.w, ),
                            child: Text("${title}",
                              style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500, fontSize: 16.sp,
                                  color: Color(0xff0D0D0D)),
                            ),
                          ), //제목
                          Container(
                              margin: EdgeInsets.only(left: 14.52.w),
                              child: Text(formatDueDate(due),
                                style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400, fontSize: 13.sp,
                                    color: Color(0xff9F9F9F)),
                              ) ), //일정
                        ],
                      ),
                    ), //텍스트(제목, 일정)
                    Expanded(
                        child: Align(alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.only(right: 20.77.w, ),
                              child: Text("요청 중",
                                style: TextStyle(
                                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500, fontSize: 11.sp,
                                    color: Color(0xff959595)),
                              )
                          ), //텍스트 수행 중/요청 중
                        )),

                  ],
                ),),
              Container(child: Center(child: Container(width: 317.66.w, child: Divider(color: Color(0xffC8C8C8), thickness: 0.5.sp)))),
            ],
          ),
        ),
        );
      }
  }
}
class order{
  int orderNo;
  String nickname; //닉네임
  double score; //평점
  order(this.orderNo, this.nickname, this.score);
  factory order.fromJson(Map<String, dynamic> json) {
    return order(
      json['orderNo'],
      json['nickname'],
      json['score'],
    );
  }
}
class Post{//게시글에 담긴 정보들
  order o1;
  int errandNo; //게시글 번호
  String createdDate; //생성된 날짜
  double? distance; //도착지 거리
  String title; //게시글 제목
  String destination; //위치
  int reward; //보수
  String status; //상태 (모집중 or 진행중 or 완료됨)
  Post(this.o1, this.errandNo, this.createdDate, this.distance,
      this.title, this.destination, this.reward, this.status);
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      order.fromJson(json['order']),
      json['errandNo'],
      json['createdDate'],
      json['distance'],
      json['title'],
      json['destination'],
      json['reward'],
      json['status'],
    );
  }
}
class InProgress_Errand{//진행중인 심부름이 간략하게 담고 있는 정보들
  int errandNo; //게시글 번호
  String title; //게시글 제목
  String due; //기간
  bool isUserOrder; //내가 요청자인지 심부름꾼인지 여부
  InProgress_Errand(this.errandNo, this.title,
      this.due, this.isUserOrder);
  factory InProgress_Errand.fromJson(Map<String, dynamic> json) {
    return InProgress_Errand(
      json['errandNo'],
      json['title'],
      json['due'],
      json['isUserOrder'],
    );
  }
}
class Error{
  String code;
  var httpStatus;
  String message;
  Error(this.code,this.httpStatus,this.message);
  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> errands = [];
  late double latitude;
  late double longitude;
  bool button1state = true; //초기 설정 값
  bool button2state = false;
  bool button3state = false;
  bool isCheckBox = false;
  String status = "";
  String? token = "";
  bool isVisible = false; //쿼카 아이콘 옆 빨간점
  Future<Position> getCurrentLocation() async {
    log("call geolocator");
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log("get position at geolocator");
      return position;

    } catch(e) {
      log("exception: " + e.toString());
      return Future.error("faild Geolocator");
    }
  }
  InprogressExist() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/in-progress/exist";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
     print("inprogress exist");
      setState(() {
        isVisible = true;
      });
    }
    else {
      print("no one");
      setState(() {
        isVisible = false;
      });
    }
  }
  InProgressErrandInit() async{
    errands.clear();
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/in-progress";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        InProgress_Errand e1 = InProgress_Errand.fromJson(item);
        errands.add({
          "errandNo": e1.errandNo,
          "title": e1.title,
          "due": e1.due,
          "isUserOrder": e1.isUserOrder,
        });
        print('inprogress errand init 200');
      }
      setState(() {});
    }
    else {
      print("진행중인 심부름 없음");
    }
  }
  ErrandLatestInit() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/latest?pk=-1&cursor=3000-01-01 00:00:00.000000&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('errand latest init 200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandRewardInit() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/reward?pk=-1&cursor=1000000&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandDistanceInit() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/distance?cursor=-1&latitude=$latitude&longitude=$longitude&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "distance": p1.distance,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('errand latest init 200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandLatestAdd() async{
    Map<String, dynamic> lastPost = posts.last;
    int lasterrandNo = lastPost['errandNo'];
    String lastcreatedDate = lastPost['createdDate'];
    String lastCreatedDate = utf8.decode(lastcreatedDate.runes.toList());
    print(lasterrandNo);
    print(lastCreatedDate);
    token = await storage.read(key: 'TOKEN');
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/latest?pk=$lasterrandNo&cursor=$lastCreatedDate&limit=12&status=$status";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
        print(lasterrandNo);
        print(lastCreatedDate);
      }
      setState(() {
      });
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandRewardAdd() async{
    Map<String, dynamic> lastPost = posts.last;
    int lasterrandNo = lastPost['errandNo'];
    int lastreward = lastPost['reward'];
    print(lasterrandNo);
    print(lastreward);
    token = await storage.read(key: 'TOKEN');
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand/reward?pk=$lasterrandNo&cursor=$lastreward&limit=12&status=$status";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandDistanceAdd() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    Map<String, dynamic> lastPost = posts.last;
    String lastdistance = lastPost['distance'];
    String url = "${base_url}errand/distance?cursor=$lastdistance&latitude=$latitude&longitude=$longitude&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "distance": p1.distance,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('errand latest init 200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  void _insertOverlay(BuildContext context) {

    if (overlayEntry != null) return;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0.h,
        left: 0.w,
        right: 0.w,
        child: Container(
          width: 360.w,
          height: 64.h,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            border: Border.all(
              color: Color(0xffCFCFCF),
              width: 0.5.w,
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
                width: 22.w,
                height: 22.h,
                margin: EdgeInsets.only(left: 44.w,  top: 20.h, bottom: 17.32.h, ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  icon: SvgPicture.asset(
                    'assets/images/home_icon.svg',
                    color: Color(0xffADADAD),
                  ),
                ),
              ),
              Container(
                width: 19.31.w,
                height: 23.81.h,
                margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,),
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/profile_icon.svg',
                    color: Color(0xffADADAD),
                  ),
                ),
              ),
              Container(
                width: 22.0.w,
                height: 22.h,
                margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,),
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => WriteErrand(),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/write_icon.svg',
                    color: Color(0xffADADAD),
                  ),
                ),
              ),
              Container(
                width: 21.95.w,
                height: 24.21.h,
                margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,
                  right: 43.92.w, ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/images/history_icon.svg',
                    color: Color(0xffADADAD),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry!);
  }
  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
  ScrollController _scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((_) {
      _insertOverlay(context);
      getCurrentLocation().then((position) {
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
      });
    });
    ErrandLatestInit(); //최신순 요청서 12개
    InprogressExist(); //진행중인 심부름이 있는지 확인
    InProgressErrandInit(); //진행중인 심부름 목록 불러오기
    _scrollController.addListener((){
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) //스크롤을 끝까지 내리면
          {
        setState(() {
          if(button1state)
           {
              ErrandLatestAdd(); //최신순 요청서 12개
           }
           else if(button2state)
           {
               ErrandRewardAdd(); //금액순 요청서 12개
           }
           else if(button3state)
           {
             ErrandDistanceAdd();
           }
          InprogressExist(); //진행중인 심부름이 있는지 확인
          InProgressErrandInit(); //진행중인 심부름 목록 불러오기
        });
      }
    });
  }
  @override
  void dispose(){
    overlayEntry?.remove();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo( // 애니메이션과 함께 맨 위로 스크롤
      0,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }
  Color button1_text_color = Color(0xff7C2E1A); //초기 색상 값
  Color button1_border_color = Color(0xff7C3D1A);
  Color button2_text_color = Color(0xff4A4A4A);
  Color button2_border_color = Color(0xffB1B1B1);
  Color button3_text_color = Color(0xff4A4A4A);
  Color button3_border_color = Color(0xffB1B1B1);
  Color checkbox_text_color = Color(0xff606060);


  void change_Button_State(){ //색 변경
    setState(() {
      if(button1state)
      {button1_text_color = Color(0xff7C2E1A);
        button1_border_color = Color(0xff7C3D1A);}
      else
        {button1_text_color = Color(0xff4A4A4A);
          button1_border_color = Color(0xffB1B1B1);}

      if(button2state)
      {button2_text_color = Color(0xff7C2E1A);
        button2_border_color = Color(0xff7C3D1A);}
      else
      {button2_text_color = Color(0xff4A4A4A);
        button2_border_color = Color(0xffB1B1B1);}

      if(button3state)
      {button3_text_color = Color(0xff7C2E1A);
      button3_border_color = Color(0xff7C3D1A);}
      else
      {button3_text_color = Color(0xff4A4A4A);
      button3_border_color = Color(0xffB1B1B1);}
    });
  }
  void change_checkbox_state()
  {
    setState(() {
      if(isCheckBox)
        {
          checkbox_text_color = Color(0xff292929);
          status = "RECRUITING";
        }

      else
        {
          checkbox_text_color = Color(0xff606060);
          status = "";
        }
    });
  }

  // 종료 버튼
  Future<bool?> _showExitDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1.w),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: 323.w,
              height: 214.h,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.h, ),
                    child:  Icon(
                      Icons.exit_to_app,
                      color: Color(0xffA98474),
                      size: 40.sp,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.h, ),
                    child: Text(
                      "정말 커카를 종료하시겠어요?",
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
                    margin: EdgeInsets.only(top: 30.h, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16.w, ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18.w, 45.h)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: Text(
                              "종료",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                letterSpacing: 0.00,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16.w, ),
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
                                      width: 1.w // 테두리 두께
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
                              Navigator.pop(context, false);
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

  // 로그아웃 버튼
  Future<bool?> _showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xffB6B6B6), width: 1.w),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: 323.w,
              height: 214.h,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.h, ),
                    child:  Icon(
                      Icons.logout,
                      color: Color(0xffA98474),
                      size: 40.sp,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.h, ),
                    child: Text(
                      "로그아웃 하시겠어요?",
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
                    margin: EdgeInsets.only(top: 30.h, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16.w, ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18.w, 45.h)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: Text(
                              "로그아웃",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                letterSpacing: 0.00,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                              await storage.delete(key: 'TOKEN');
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16.w, ),
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
                                      width: 1.w // 테두리 두께
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




  // void _showLogoutDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.all(17),
  //           width: 300,
  //           height: 180,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.logout,
  //                 color: Colors.brown,
  //                 size: 40,
  //               ),
  //               SizedBox(height: 10),
  //               Text(
  //                 "로그아웃 하시겠습니까?",
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               SizedBox(height: 11),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Expanded(
  //                     child: ElevatedButton(
  //                       onPressed: () async {
  //                         Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
  //                         await storage.delete(key: 'TOKEN');
  //                         },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.brown, // 갈색으로 설정
  //                         foregroundColor: Colors.white,
  //                         padding: EdgeInsets.symmetric(vertical: 10),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                       ),
  //                       child: Text("로그아웃"),
  //                     ),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     child: TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       style: TextButton.styleFrom(
  //                         foregroundColor: Colors.brown,
  //                         padding: EdgeInsets.symmetric(vertical: 10),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         side: BorderSide(color: Colors.brown),
  //                       ),
  //                       child: Text("취소"),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showExitDialog() ?? false;
        if (context.mounted && shouldPop) {
            SystemNavigator.pop();
        }
      },
      child: Scaffold(
          body: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(width: 57.0.w, height: 25.0.h,
                            margin: EdgeInsets.only(
                                left: 27.w,
                                top: 33.h, ),
                            child: Text(
                              '게시글',
                              style: TextStyle(
                                fontFamily: 'paybooc',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.01,
                                color: Color(0xff111111),
                              ),),),
                         // SizedBox(width: 194),
                          SizedBox(width: 157.w, ),
                          Container(width: 23.0.w, height: 21.91.h,
                            margin: EdgeInsets.only(top: 29.h, right: 14.w,),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed:
                                  () {
                                _showLogoutDialog();
                                  },
                              icon: Icon(
                                Icons.logout,
                                color: Color(0xffB4B5BE),
                                size: 28.sp,
                              ),
                            ),
                          ),
                           Container(width: 23.0.w, height: 21.91.h,
                            margin: EdgeInsets.only(top: 35.h, right: 14.w,),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed:
                                  () {},
                              icon: SvgPicture.asset('assets/images/search_icon.svg',
                                color: Color(0xffB4B5BE),
                              ),
                            ),
                          ),
                          Container(width: 23.0.w, height: 21.91.h,
                            margin: EdgeInsets.only(top: 34.h, right: 21.31.w,),
                            child: IconButton(
                              style: IconButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/images/alarm_icon.svg',
                                color: Color(0xffB4B5BE),
                              ),
                            ),)
                        ],
                      )
                  ),
                  Container(
                    child: Row(
                      children: [
                        GestureDetector( //버튼1
                          onTap: () {
                            button1state = true;
                            button2state = false;
                            button3state = false;
                            change_Button_State();
                            posts.clear();
                            ErrandLatestInit();
                            InprogressExist();
                            InProgressErrandInit();
                            scrollToTop();
                          },
                          child: Container(width: 70.w, height: 32.h,
                            margin: EdgeInsets.only(left: 27.w, top: 19.h, ),
                            child: Stack(
                              children: [
                                Positioned(left: 0.w, top: 0.h,
                                  child: Container(width: 70.w, height: 32.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFBFBFB),
                                      border: Border.all(
                                        color: button1_border_color, width: 1.w,),
                                      borderRadius: BorderRadius.circular(10),
                                    ),),), // Text
                                Positioned(left: 16.72.w, top: 7.72.h,
                                  child: Text('최신순', style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    letterSpacing: 0.001,
                                    color: button1_text_color,
                                  ),),),
                              ],),),),
                        GestureDetector( //버튼2
                          onTap: () {
                            button1state = false;
                            button2state = true;
                            button3state = false;
                            change_Button_State();
                            posts.clear();
                            ErrandRewardInit();
                            InprogressExist();
                            InProgressErrandInit();
                            scrollToTop();
                          },
                          child: Container(width: 70.w, height: 32.h,
                            margin: EdgeInsets.only(
                                left: 11.w,
                                top: 19.h,
                            ),
                            child: Stack(
                              children: [
                                Positioned(left: 0.w, top: 0.h,
                                  child: Container(width: 70.w, height: 32.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFBFBFB),
                                      border: Border.all(
                                        color: button2_border_color, width: 1.w,),
                                      borderRadius: BorderRadius.circular(10),
                                    ),),), // Text
                                Positioned(
                                  left: 16.72.w,
                                  top: 7.72.h,
                                  child: Text('금액순', style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    letterSpacing: 0.001,
                                    color: button2_text_color,
                                  ),),),
                              ],),),),
                        GestureDetector( //버튼3
                          onTap: () {
                            button1state = false;
                            button2state = false;
                            button3state = true;
                            change_Button_State();
                            posts.clear();
                            ErrandDistanceInit();
                            InprogressExist();
                            InProgressErrandInit();
                            scrollToTop();
                          },
                          child: Container(width: 70.w, height: 32.h,
                            margin: EdgeInsets.only(
                                left: 11.w,
                                top: 19.h,
                            ),
                            child: Stack(
                              children: [
                                Positioned(left: 0.w, top: 0.h,
                                  child: Container(width: 70.w, height: 32.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFBFBFB),
                                      border: Border.all(
                                        color: button3_border_color, width: 1.w,),
                                      borderRadius: BorderRadius.circular(10),
                                    ),),), // Text
                                Positioned(
                                   left: 16.72.w,
                                   top: 7.72.h,
                                  child: Text('거리순', style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    letterSpacing: 0.001,
                                    color: button3_text_color,
                                  ),),),
                              ],),),)
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(width: 20.w, height: 20.h,
                          margin: EdgeInsets.only(
                              left: 27.w,
                              top: 16.36.h,
                          ),
                          child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) =>
                                  BorderSide(
                                      width: 1.0.w, color: Color(0xffC5C5C5)),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            activeColor: Color(0xffA97651),
                            value: isCheckBox,
                            onChanged: (value) {
                              setState(() {
                                isCheckBox = value!;
                                change_checkbox_state();
                                posts.clear();
                                if (button1state)
                                  ErrandLatestInit();
                                else if (button2state)
                                  ErrandRewardInit();
                                else if(button3state)
                                  ErrandDistanceInit();
                              });
                            },
                          ),
                        ),
                        Container(height: 17.w,
                          margin: EdgeInsets.only(
                              left:2.28.w,
                              top: 14.86.h,
                          ),
                          child: Text('모집 중 모아보기', style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            letterSpacing: 0.001,
                            color: checkbox_text_color,
                          ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.36.h, ),
                  Flexible(
                    child: Container(width: 322.w, height: 581.h,
                      //게시글 큰틀
                      margin: EdgeInsets.only(left: 19.w, ),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 0.1.h, bottom: 45.h,),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            String nickname = posts[index]["nickname"];
                            String title = posts[index]['title'];
                            String destination = posts[index]['destination'];
                            String createdDate = posts[index]["createdDate"];
                            String decodedNickname = utf8.decode(
                                nickname.runes.toList());
                            String decodedTitle = utf8.decode(
                                title.runes.toList());
                            String decodedDestination = utf8.decode(
                                destination.runes.toList());
                            String decodedCreatedDate = utf8.decode(
                                createdDate.runes.toList());
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              //게시글 전체를 클릭영역으로 만들어주는 코드
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainErrandCheck(
                                              errandNo: posts[index]["errandNo"])
                                  ),);
                              },
                              child: PostWidget(
                                orderNo: posts[index]["orderNo"],
                                nickname: decodedNickname,
                                score: posts[index]["score"],
                                errandNo: posts[index]["errandNo"],
                                createdDate: decodedCreatedDate,
                                distance: posts[index]["distance"],
                                title: decodedTitle,
                                destination: decodedDestination,
                                reward: posts[index]["reward"],
                                status: posts[index]["status"],
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 84.h,
              right: 7.w,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 55.w, height: 55.h,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 389.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  border: Border(
                                    top: BorderSide(
                                        width: 0.5.w, color: Colors.grey),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 13.47.h,
                                      left: 127.74.w,
                                      child: Container(
                                        width: 104.51.w,
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xffAEAEAE),
                                          border: Border.all(
                                            width: 5.w,
                                            color: Color(0xffAEAEAE),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 42.64.h,
                                      left: 19.64.w,
                                      child: Text(
                                        '메세지를 보낼 심부름 상대를 골라주세요',
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 85.39.h,
                                      child: Container(
                                        width: 360.w,
                                        height: 310.14.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          border: Border(
                                            top: BorderSide(width: 0.1),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: errands.isEmpty
                                            ? Center(
                                            child: Text("진행중인 심부름이 없습니다."))
                                            : ListView.builder(
                                          padding: EdgeInsets.only(
                                              top: 23.98.h,
                                              bottom: 50.h,
                                          ),
                                          itemCount: errands.length,
                                          itemBuilder: (context, index) {
                                            String decodedTitle = utf8.decode(
                                                errands[index]["title"].runes
                                                    .toList());
                                            String decodedDue = utf8.decode(
                                                errands[index]["due"].runes
                                                    .toList());
                                            return InProgress_Errand_Widget(
                                              errandNo: errands[index]["errandNo"],
                                              title: decodedTitle,
                                              due: decodedDue,
                                              isUserOrder: errands[index]["isUserOrder"],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: SvgPicture.asset('assets/images/quokka.svg',width: 56.w,
                            height: 56.h,
                            fit: BoxFit.cover),
                      ),),
                    Container(
                      width: 12.w, height: 12.h,
                      margin: EdgeInsets.only(bottom: 42.86.h, ),
                      child: Visibility(
                        visible: isVisible,
                        child: SvgPicture.asset(
                            'assets/images/red_dot_alarm.svg', width: 10.w,
                            height: 10.h,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ]
              ),
            ),
          ],)
      )
    );
  }
}

