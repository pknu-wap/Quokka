import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'errand_write.dart';
import 'main_post_page.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage(); // 토큰 받기

// class ErrandCheck extends StatelessWidget {
//
//   // const ErrandCheck({
//   //   Key? key,
//   //   required this.errandNo,
//   // }) : super(key: key);

class ErrandCheckWidget extends StatelessWidget {
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
  const ErrandCheckWidget({
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

  // 글보기 상세 페이지
  @override
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat('###,###,###,###');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 320, height: 305.85, //게시글 1개
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //닉네임, 평점
                Container(
                    margin: EdgeInsets.only(top: 13.01),
                    child: Row(
                  children: [
                    //닉네임
                    Container(
                      margin: EdgeInsets.only(left: 13.4),
                      child: Text(
                        "${nickname}",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          letterSpacing: 0.001,
                          color: Color(0xff575757),
                        ),
                      ),
                    ),
                    // 평점 커카 이미지
                    Container(
                      margin: EdgeInsets.only(left: 9.1),
                      child: Image.asset(
                        'assets/images/score_icon.png',
                        // Replace with your image asset path
                        width: 11.77, // Adjust the size as needed
                        height: 11.77, // Adjust the size as needed
                        color: Color(0xffCFB6A5),
                      ),
                    ),
                    //평점
                    Container(
                      margin: EdgeInsets.only(left: 2.82),
                      child: Text(
                        " ${score}점",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          letterSpacing: -0.03,
                          color: Color(0xffCFB6A5),
                        ),
                      ),
                    ),
                  ],
                )),
                //게시글 제목
                Container(
                  margin: EdgeInsets.only(top: 10.59, left: 13.4, right: 18.6),
                  child: Text(
                    "${title}",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 0.001,
                      color: Color(0xff111111),
                    ),
                  ),
                ),
                // 심부름 값
                Container(
                  margin: EdgeInsets.only(top: 11.52, left: 13.4),
                  child: Text(
                    "\u20A9 ${priceFormat.format(reward)} 원",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 0.001,
                      color: Color(0xff7C3D1A),
                    ),
                  ),
                ),
                // 상세 주소
                Container(
                    margin: EdgeInsets.only(top: 22.06),
                    child: Row(
                      children: [
                        // 마커 이미지
                        Container(
                          margin: EdgeInsets.only(left: 18.97),
                          child: Image.asset(
                            'assets/images/marker_small.png',
                            // Replace with your image asset path
                            width: 12.2, // Adjust the size as needed
                            height: 16.77, // Adjust the size as needed
                          ),
                        ),
                        // 상세 주소 텍스트
                        Container(
                          margin: EdgeInsets.only(left: 7.67),
                          child: Text(
                            "상세 주소",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.001,
                              color: Color(0xffBC9F9F),
                            ),
                          ),
                        ),
                        // 상세 주소 정보
                        Container(
                          margin: EdgeInsets.only(left: 7),
                          child: Text(
                            "${destination}",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              letterSpacing: 0.001,
                              color: Color(0xff505050),
                            ),
                          ),
                        ),
                      ],
                    )),

                Container(
                    margin: EdgeInsets.only(top: 8.28),
                    child: Row(
                      children: [
                        // 시계 이미지
                        Container(
                          margin: EdgeInsets.only(left: 18.53),
                          child: Image.asset(
                            'assets/images/clock.png',
                            width: 15.08, // Adjust the size as needed
                            height: 15.08, // Adjust the size as needed
                          ),
                        ),
                        // 일정 텍스트
                        Container(
                          margin: EdgeInsets.only(left: 6.23),
                          child: Text(
                            "일정",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.001,
                              color: Color(0xffBC9F9F),
                            ),
                          ),
                        ),
                        // 일정
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            "${due}",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              letterSpacing: 0.001,
                              color: Color(0xff505050),
                            ),
                          ),
                        ),
                        Container(
                          //게시글 올린 시간
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "${createdDate}",
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                letterSpacing: 0.001,
                                color: Color(0xff434343)),
                          ),
                        ),
                      ],
                    )),
                // 실선
                Container(
                  margin: EdgeInsets.only(top: 24.68, left: 12.01, right: 9.99),
                  height: 1.0,
                  width: 298,
                  color: Color(0xffDBDBDB),
                ),
                // 요청 사항
                Container(
                  margin: EdgeInsets.only(top: 15.61, left: 20.66, right: 19.34),
                  child:  Text(
                    "${detail}",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
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

  // const MainErrandCheck({Key? key}) : super(key: key);

  @override
  State createState() => _MainErrandCheckState();
}

class _MainErrandCheckState extends State<MainErrandCheck> {
  List<Map<String, dynamic>> errands = [];
  String status = "";
  String? token = "";
  late int errandNo;
  late NLatLng myLatLng;
  late NMarker marker;

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
      setState(() {});
    } else {
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      print(error.code);
      print(error.httpStatus);
      print(error.message);
    }
  }

  @override
  void initState() {
    super.initState();
    errandNo = widget.errandNo;
    myLatLng = NLatLng(35.134384930841364, 129.10592409493796); // 백엔드에서 값 받아오기
    marker = NMarker(
      id: "도착지",
      position: myLatLng,
    );
    errandReading(errandNo.toString());
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // 네이버 지도
                        Container(
                          margin: EdgeInsets.only(left: 19, top: 50),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffC6C6C6), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffFFFFFF),
                          ),
                          width: 320,
                          height: 212,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: NaverMap(
                              options: const NaverMapViewOptions(
                                logoClickEnable: false,
                                // 네이버 로고 클릭 비활성화

                                mapType: NMapType.basic,
                                // 지도 유형 : 기본 지도(기본 값)
                                activeLayerGroups: [
                                  // 표시할 정보
                                  NLayerGroup.building, // 건물 레이어
                                  NLayerGroup.transit, // 대중교통 레이어
                                ],
                                // 제스처의 마찰계수 지정(0.0~1.0 -> 0: 미끄러움)
                                scrollGesturesFriction: 0.5,
                                // 스크롤
                                zoomGesturesFriction: 0.5,
                                // 줌

                                initialCameraPosition: NCameraPosition(
                                    target: NLatLng(35.134384930841364,
                                        129.10592409493796), // 내 위치
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

                              onMapTapped: (point, latLng) {
                                // 지도가 터치될 때마다 마커의 위치를 업데이트
                                print("marker 이동!");
                                // log(point.toString());
                                // log(latLng.toString());

                                setState(() {
                                  marker.setPosition(latLng);
                                  marker.setIsVisible(
                                      true); // 새로운 값이 들어오면 마커 다시 보이도록 설정
                                });
                              },

                              onSymbolTapped: (symbol) {
                                setState(() {
                                  marker.setPosition(
                                      symbol.position); // marker 위치 이동
                                  marker.setIsVisible(true);
                                });
                                log(symbol.caption.toString());
                              },
                              forceGesture: true,
                              // SingleChildScrollView 안에서 사용하므로, NaverMap에
                              // 전달되는 제스처 무시 현상 방지 위함
                            ),
                          ),
                        ),
                      ],
                    )),

                    // if (ErrandCheckWidget(errandNo))
                    Flexible(
                      child: Container(
                        width: 320,
                        height: 305.85,
                        //게시글 큰틀
                        margin: EdgeInsets.only(left: 19, top: 18.9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffFFFFFF),
                        ),
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: 0.1, bottom: 45),
                            // controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: errands.length,
                            itemBuilder: (BuildContext context, int index) {
                              String nickname = errands[index]["nickname"];
                              String createdDate =
                                  errands[index]["createdDate"];
                              String title = errands[index]['title'];
                              String destination =
                                  errands[index]['destination'];
                              String due = errands[index]['due'];
                              String detail = errands[index]['detail'];
                              String status = errands[index]['status'];

                              String decodedNickname =
                                  utf8.decode(nickname.runes.toList());
                              String decodedCreatedDate =
                                  utf8.decode(createdDate.runes.toList());
                              String decodedTitle =
                                  utf8.decode(title.runes.toList());
                              String decodedDestination =
                                  utf8.decode(destination.runes.toList());
                              String decodedDue =
                                  utf8.decode(due.runes.toList());
                              String decodedDetail =
                                  utf8.decode(detail.runes.toList());
                              String decodedStatus =
                                  utf8.decode(status.runes.toList());
                              return GestureDetector(
                                // behavior: HitTestBehavior.translucent,
                                //게시글 전체를 클릭영역으로 만들어주는 코드
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //       builder: (context) => MainErrandCheck(errandNo: posts[index]["errandNo"])
                                  //   ),);
                                },
                                child: ErrandCheckWidget(
                                  orderNo: errands[index]["orderNo"],
                                  nickname: decodedNickname,
                                  score: errands[index]["score"],
                                  errandNo: errands[index]["errandNo"],
                                  createdDate: decodedCreatedDate,
                                  title: decodedTitle,
                                  destination: decodedDestination,
                                  latitude: errands[index]["latitude"],
                                  longitude: errands[index]["longitude"],
                                  due: decodedDue,
                                  detail: decodedDetail,
                                  reward: errands[index]["reward"],
                                  isCash: errands[index]["isCash"],
                                  status: decodedStatus,
                                  isMyErrand: errands[index]["isMyErrand"],
                                ),
                              );
                            }),
                      ),
                    ),

                    if (errands[0]["isMyErrand"] == false)
                    // 제가 할게요! 버튼(글 보기 하는 사람)
                    Container(
                      margin: EdgeInsets.only(left: 21, right: 21, top: 13.32),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          print("제가 할게요! 클릭");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF7C3D1A)),
                          // 버튼의 크기 정하기
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(318, 46.65)),
                          // 버튼의 모양 변경하기
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5), // 원하는 모양에 따라 BorderRadius 조절
                            ),
                          ),
                        ),
                        child: Text(
                          '제가 할게요!',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    if (errands[0]["isMyErrand"] == true)
                    // 수정하기, 삭제하기 버튼(글 보기 올린 사람)
                    Container(
                      margin: EdgeInsets.only(top: 13.38),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 18),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  print("수정하기 버튼");
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xffFFFFFF)),
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
                                          color: Color(0xff9B9B9B),
                                          width: 1,
                                        )),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min, // 중앙 정렬
                                  children: [
                                    Image.asset(
                                      'assets/images/Pencil_2_.png',
                                      // Replace with your image asset path
                                      width: 19.12,
                                      height: 19.12,
                                      color: Color(0xFF7F7F7F),
                                    ),
                                    SizedBox(width: 6.55),
                                    // Adjust the space between icon and text as needed
                                    Text(
                                      '수정하기',
                                      style: TextStyle(
                                        fontSize: 15,
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
                            margin: EdgeInsets.only(left: 17.55, right: 20.99),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                print("삭제하기 버튼");
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xffFFFFFF)),
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
                                    color: Color(0xffFF2929),
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
                              onPressed: () {},
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
