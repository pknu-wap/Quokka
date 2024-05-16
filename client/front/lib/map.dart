import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapTest extends StatefulWidget {
  @override
  State<NaverMapTest> createState() => _NaverMapTestState();
}



class _NaverMapTestState extends State<NaverMapTest> {
  TextEditingController destinationController = TextEditingController();
  bool isDestinationEnabled = false;
  // 선택된 좌표 타입 (0: 마커 생성 불가능, 1: 가능)
  int selectType = 0;

  // 선택 좌표 표시 마커
  final marker = NMarker(
    id: "test",
    position: NLatLng(35.134384930841364, 129.10592409493796),
    // icon: iconImage,
  );

  // final iconImage = NOverlayImage.fromAssetImage('assets/images/location.png');
  late NMarker selectedMarker;

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    destinationController.addListener(updateDestinationState);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    destinationController.dispose();
    super.dispose();
  }

  void updateDestinationState() {
    // 중복확인 입력란의 텍스트 변경 감지하여 버튼의 도착지 활성화 상태 업데이트
    setState(() {
      isDestinationEnabled = destinationController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 19.0, top: 34.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      '도착지 찾기',
                      style: TextStyle(
                        fontFamily: 'Paybooc',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111111),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              // 네이버 지도
              Container(
                margin: EdgeInsets.only(left: 0, top: 25.55),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: 318.85,
                      height: 508.67,
                      margin: EdgeInsets.only(left: 0),
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
                                target: NLatLng(35.13345439211669, 129.1021265479746),
                                // 위도, 경도
                                // 부경대 대연캠퍼스
                                // 위도 latitude : 35.13345439211669
                                // 경도 longitude : 129.1021265479746
                                zoom: 14, // 지도의 초기 줌 레벨
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
                            log(point.toString());
                            print("marker 이동!");
                            log(latLng.toString());

                            setState(() {
                              selectedMarker = NMarker(
                                id: "selectedMarker",
                                position: latLng,
                              );
                            });



                            // setState(() {
                            //   selectedMarker = NMarker(
                            //     id: "selectedMarker",
                            //     position: latLng,
                            //     // icon: marker.icon, // 아이콘은 그대로 유지
                            //   );
                            // });
                          },

                          // onMapTapped: (point, latLng) {
                          //   setState(() {
                          //     // 새로운 NMarker 객체를 생성하여 마커의 위치를 클릭한 위치로 업데이트
                          //     selectedMarker = NMarker(
                          //       id: marker.id, // 이전 마커의 id를 유지합니다.
                          //       position: latLng,
                          //       // 다른 속성들은 유지하거나 필요에 따라 변경할 수 있습니다.
                          //     );
                          //   });
                          // },
                          forceGesture: true,
                          // SingleChildScrollView 안에서 사용하므로, NaverMap에
                          // 전달되는 제스처 무시 현상 방지 위함
                        ),
                      ),
                    ),
                    // 도착지 찾기 텍스트 필드
                    Container(
                      margin: EdgeInsets.only(top: 18.82),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            width: 283.97,
                            height: 40,
                            margin: EdgeInsets.only(left: 16.86),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffD3D3D3), width: 1 // 테두리 굵기
                                  ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 37.65, right: 37.65),
                              child: TextField(
                                controller: destinationController,
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  letterSpacing: 0.01,
                                  color: Color(0xff373737),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                                // enabled: isCompletedEnabled,
                              ),
                            ),
                          ),
                          // 검색 아이콘
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 26, top: 3),
                                color: Colors.transparent,
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xffB9BCC6),
                                ),
                              ),
                            ),
                          ),
                          // 닫기 버튼 아이콘
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 268, top: 3),
                                color: Colors.transparent,
                                child: Image.asset(
                                  'assets/images/close_circle.png',
                                  width: 20.43,
                                  height: 20.43,
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
              // 도착지로 설정할게요 버튼
              Container(
                margin: EdgeInsets.only(left: 23.0, right: 19.0, top: 38.63),
                child: ElevatedButton(
                  onPressed: isDestinationEnabled
                      ? () {
                          print("도착지로 설정하게요 클릭!");
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isDestinationEnabled
                          ? Color(0xFF7C3D1A)
                          : Color(0xFFBD9E8C),
                    ),
                    // 버튼의 크기 정하기
                    minimumSize: MaterialStateProperty.all<Size>(Size(318, 41)),
                    // 버튼의 모양 변경하기
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5), // 원하는 모양에 따라 BorderRadius 조절
                      ),
                    ),
                  ),
                  child: Text(
                    '도착지로 설정할게요',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                    ),
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

