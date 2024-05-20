import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'main_post_page.dart';
import 'package:http/http.dart' as http;

// class ErrandCheck extends StatelessWidget {
//
//   // const ErrandCheck({
//   //   Key? key,
//   //   required this.errandNo,
//   // }) : super(key: key);

class ErrandCheck extends StatefulWidget {
  final int errandNo;
  // const ErrandCheck({Key? key, required this.errandNo}) : super(key: key);
  const ErrandCheck({super.key, required this.errandNo});

  @override
  State createState() => _ErrandCheckState();
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
class Errand { // 게시글에 담긴 정보들
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
  Errand(this.o1, this.errandNo, this.createdDate, this.title,
      this.destination, this.latitude, this.longitude,
      this.due, this.detail, this.reward, this.isCash,
      this.status, this.isMyErrand);
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
  Error(this.code,this.httpStatus,this.message);
  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}

class _ErrandCheckState extends State<ErrandCheck> {
  List<Map<String, dynamic>> errands = [];
  String status = "";
  String? token = "";
  late int errandNo;
  late NLatLng myLatLng;
  late NMarker marker;

  ErrandReading(String id) async {
  String base_url = dotenv.env['BASE_URL'] ?? '';
  String url = "${base_url}errand";
  String param = "/$id";
  print(url + param);

  token = await storage.read(key: 'TOKEN');
  var response = await http.get(Uri.parse(url+param),
    headers: {"Authorization" : "$token"});

  if (response.statusCode == 200){
    List<dynamic> result = jsonDecode(response.body);
    Errand errand = Errand.fromJson(result);
    errands.add({
      "orderNo": errand.o1.orderNo,
      "nickname": errand.o1.nickname,
      "score": errand.o1.score,
      "errandNo": errand.errandNo,
      "createdDate": errand.createdDate,
      "title": errand.title,
      "destination": errand.destination,
      "latitude" : errand.latitude,
      "longitude" : errand.longitude,
      "due" : errand.due,
      "detail" : errand.detail,
      "reward": errand.reward,
      "isCash" : errand.isCash,
      "status": errand.status,
      "isMyErrand" : errand.isMyErrand,
    });
    print('200');
    }
  setState(() {});
  }

  @override
  void initState(){
    super.initState();
    errandNo = widget.errandNo;
    myLatLng = NLatLng(35.134384930841364, 129.10592409493796); // 백엔드에서 값 받아오기
    marker = NMarker(
      id: "도착지",
      position: myLatLng,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 네이버 지도
              Container(
                margin: EdgeInsets.only(left: 19, top: 49),
                decoration: BoxDecoration(
                  border:
                    Border.all(color: Color(0xffC6C6C6), width: 1
                    ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffFFFFFF),
                ),
                width: 320,
                height: 212,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: NaverMap(
                    options: const NaverMapViewOptions(
                      locationButtonEnable: true, // 내 위치 버튼 활성화
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
                          target: NLatLng(35.134384930841364, 129.10592409493796), // 내 위치
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
                        marker.setIsVisible(true); // 새로운 값이 들어오면 마커 다시 보이도록 설정
                      });
                    },

                    onSymbolTapped: (symbol) {
                      setState(() {
                        marker.setPosition(symbol.position);  // marker 위치 이동
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

              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Text("$errandNo", style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 100,
                  color: Color(0xFF404040),
                 ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Text("$errandNo", style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 100,
                  color: Color(0xFF404040),
                ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}








