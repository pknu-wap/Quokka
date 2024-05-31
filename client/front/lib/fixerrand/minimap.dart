import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

import '../map.dart';

class MiniMap extends StatefulWidget{
  final double latitude; // 위도
  final double longitude; // 경도
  MiniMap({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  late double latitude;
  late double longitude;

  late NLatLng myLatLng; // 사용자의 위치 -> 위도 경도
  late NMarker marker; // 사용자의 위치를 받아온 초기 마커 위치

  NLatLng value = NLatLng(0, 0);
  late NaverMapController mapController; // 지도 컨트롤
  double zoom = 14.5;

  NOverlayImage destIcon = NOverlayImage.fromAssetImage(
      "assets/images/map_dest.png");

  // 내 위치 받기
  // Future<Position> getCurrentLocation() async {
  //   log("call geolocator");
  //   try {
  //     LocationPermission permission;
  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.deniedForever) {
  //         return Future.error('Location Not Available');
  //       }
  //     }
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     log("get position at geolocator");
  //     return position;
  //   } catch (e) {
  //     log("exception: " + e.toString());
  //     return Future.error("faild Geolocator");
  //   }
  // }

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    initializeMap();
  }

  void initializeMap() {
    latitude = widget.latitude;
    longitude = widget.longitude;

    myLatLng = NLatLng(latitude, longitude);
    value = myLatLng;
    marker = NMarker(
      id: "test",
      position: myLatLng,
    );
    marker.setIcon(destIcon);

    // getCurrentLocation().then((position) {
    //   setState(() {
    //     myLatLng = NLatLng(position.latitude, position.longitude);
    //     value = myLatLng;
    //     marker = NMarker(
    //       id: "test",
    //       position: myLatLng,
    //     );
    //     marker.setIcon(destIcon);
    //   });
    // });
  }
  // 네이버 미니 지도
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 318.85,
                height: 120,
                margin: EdgeInsets.only(left: 2, top: 6),
                decoration: BoxDecoration(
                  border:
                  Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xffFFFFFF),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: NaverMap(
                    options: NaverMapViewOptions(
                      scrollGesturesEnable: false,
                      // 스크롤 비활성화
                      zoomGesturesEnable: false,
                      // 줌 비활성화

                      // locationButtonEnable: true, // 내 위치 버튼 활성화
                      logoClickEnable: false,
                      // 네이버 로고 클릭 비활성화

                      mapType: NMapType.basic,
                      // 지도 유형 : 기본 지도(기본 값)
                      activeLayerGroups: [ // 표시할 정보
                        NLayerGroup.building, // 건물 레이어
                        NLayerGroup.transit, // 대중교통 레이어
                      ],
                      initialCameraPosition: NCameraPosition(
                          target: myLatLng, // 내 위치
                          // 위도, 경도
                          // 부경대 대연캠퍼스
                          // 위도 latitude : 35.134384930841364
                          // 경도 longitude : 129.10592409493796
                          zoom: zoom, // 지도의 초기 줌 레벨
                          bearing: 0, // 지도의 회전 각도(0 : 북쪽이 위)
                          tilt: 0 // 지도의 기울기 각도(0 : 평면으로 보임)
                      ),
                    ),

                    onMapReady: (controller) {
                      log("request.dart로 이동!");
                      log(value.toString());
                      controller.addOverlay(marker); // 마커를 지도 위에 올리기
                      mapController = controller;
                      print("네이버 맵 로딩됨!");
                    },

                    onMapTapped: (point, latLng) async {
                      // 지도가 터치될 때마다 마커의 위치를 업데이트
                      print("marker 이동!");
                      final returnValue = await Navigator.push(
                        //로그인 버튼 누르면 게시글 페이지로 이동하게 설정
                        context,
                        MaterialPageRoute(builder: (context) =>
                            NaverMapTest(value: value, zoom: zoom)),
                      );
                      // log(point.toString());
                      // log(latLng.toString());

                      setState(() {
                        value = returnValue.value;
                        zoom = returnValue.zoom;
                        marker.setPosition(value);
                        marker.setIsVisible(
                            true); // 새로운 값이 들어오면 마커 다시 보이도록 설정
                      });
                      mapController.updateCamera(
                        NCameraUpdate.scrollAndZoomTo(
                          target: NLatLng(value.latitude, value.longitude),
                          zoom: zoom,
                        ),
                      );
                    },

                    onSymbolTapped: (symbol) {
                      setState(() {
                        marker.setPosition(value); // marker 위치 이동
                        marker.setIsVisible(true);
                      });
                      final cameraPosition = NCameraPosition(
                          target: NLatLng(value.latitude, value.longitude),
                          zoom: zoom
                      );
                      final cameraUpdate = NCameraUpdate.fromCameraPosition(
                          cameraPosition);
                      cameraUpdate.setAnimation(
                          animation: NCameraAnimation.fly,
                          duration: Duration(seconds: 2)
                      );
                      mapController.updateCamera(cameraUpdate);
                      log("지도의 심볼 클릭 -> 미니 지도에 표시");
                    },
                    forceGesture: true,
                    // SingleChildScrollView 안에서 사용하므로, NaverMap에
                    // 전달되는 제스처 무시 현상 방지 위함
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