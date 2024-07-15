import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'errand_list.dart';
import 'writeerrand.dart';
final storage = FlutterSecureStorage();
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
class ReShowMap extends StatefulWidget {
  const ReShowMap({super.key, required this.errandNo});
  final String errandNo;

  @override
  State<ReShowMap> createState() => _ReShowMapState();
}


class _ReShowMapState extends State<ReShowMap> {
  bool isDestinationEnabled = false;
  late String errandNo;
  NLatLng myLatLng = NLatLng(35.134384930841364,129.10592409493796);
  double zoom = 14.5;
  late NMarker marker;
  late NaverMapController mapController;
  NOverlayImage destIcon = NOverlayImage.fromAssetImage("assets/images/map_dest.png");
  late NLatLng returnValue;
  double returnZoom = 14.5;
  String? token = "";

  Future<void> readingNLatLng(String id) async {
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String param = "/$id";
    print(url + param);
    token = await storage.read(key: 'TOKEN');
    var response = await http
        .get(Uri.parse(url + param), headers: {"Authorization": "$token"});

    if (response.statusCode == 200) {
      Errand errand = Errand.fromJson(jsonDecode(response.body));
      double latitude = errand.latitude;
      double longitude = errand.longitude;
      log("status code == 200, Json Data Parsed.");
      setState(() {
        myLatLng = NLatLng(latitude,longitude);
        marker = NMarker(
          id: "test",
          position: myLatLng,
        );
        marker.setIcon(destIcon);
      });
    } else {
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      print(error.code);
      print(error.httpStatus);
      print(error.message);
    }
  }
  bool _isLoading = true;
  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    errandNo = widget.errandNo;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    });
    // 이후 권한 설정 관련 코드 추가 예정 -> 한 번 권한 허용 받으면 이후 권한 받을 필요 없음.
    // getGeoData();
    readingNLatLng(errandNo).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) async {
      if (didPop) {
        _insertOverlay(context);
        return;
      }
      Navigator.of(context).pop();
    },
      child: _isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 19.0.w, top: 34.0.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        '도착지 확인',
                        style: TextStyle(
                          fontFamily: 'Paybooc',
                          fontWeight: FontWeight.w700,
                          color: Color(0xff111111),
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // 네이버 지도
                Container(
                  margin: EdgeInsets.only(left: 0.w, top: 25.55.h),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: 318.85.w,
                        height: 508.67.h,
                        margin: EdgeInsets.only(left: 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: NaverMap(
                            options: NaverMapViewOptions(
                              locationButtonEnable: false, // 내 위치 버튼 비활성화
                              logoClickEnable: false, // 네이버 로고 클릭 비활성화

                              mapType: NMapType.basic, // 지도 유형 : 기본 지도(기본 값)
                              activeLayerGroups: [ // 표시할 정보
                                NLayerGroup.building, // 건물 레이어
                                NLayerGroup.transit, // 대중교통 레이어
                              ],
                              zoomGesturesFriction: 0.5, // 줌
                              // 제스처의 마찰계수 지정(0.0~1.0 -> 0: 미끄러움)
                              initialCameraPosition: NCameraPosition(
                                target: myLatLng, // 내 위치
                                zoom: zoom, // 지도의 초기 줌 레벨
                                bearing: 0, // 지도의 회전 각도(0 : 북쪽이 위)
                                tilt: 0, // 지도의 기울기 각도(0 : 평면으로 보임)
                              ),
                            ),

                            onMapReady: (controller) {
                              mapController = controller;
                              controller.addOverlay(marker);
                              print("네이버 맵 로딩됨!");
                            },

                            forceGesture: true,
                            // SingleChildScrollView 안에서 사용하므로, NaverMap에
                            // 전달되는 제스처 무시 현상 방지 위함
                          ),
                        ),
                      ),
                      // 도착지 찾기 텍스트 필드
                    ],
                  ),
                ),
                // 도착지로 설정할게요 버튼
                Container(
                  margin: EdgeInsets.only(left: 23.w, right: 19.0.w, top: 38.63.h),
                  child: ElevatedButton(
                    onPressed: marker.isVisible
                        ? () {
                      Navigator.pop(context);
                    }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (marker.isVisible) {
                              return Color(
                                  0xFF7C3D1A); // 활성화된 배경색(모든 텍스트 필드 비어있지 않은 경우)
                            } else {
                              return Color(
                                  0xFFBD9E8C); // 비활성화 배경색(하나의 텍스트 필드라도 비어있는 경우)
                            }
                          }),
                      // 버튼의 크기 정하기
                      minimumSize: MaterialStateProperty.all<Size>(Size(318.w, 41.h)),
                      // 버튼의 모양 변경하기
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // 원하는 모양에 따라 BorderRadius 조절
                        ),
                      ),
                    ),
                    child: Text(
                      '도착지를 확인했어요',
                      style: TextStyle(
                        fontSize: 14.sp,
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
      ),
    );

  }
}