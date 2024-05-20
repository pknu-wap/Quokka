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

class _ErrandCheckState extends State<ErrandCheck> {
  late int errandNo;
  late NLatLng myLatLng;
  late NMarker marker;

  request(String id) async {
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}errand";
    String param = "/$id";
    print(url + param);
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






