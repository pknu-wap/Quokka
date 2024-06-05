import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import '../map.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'checkerrand.dart';
import 'home.dart';
final storage = FlutterSecureStorage();
void _insertOverlay(BuildContext context) {
  if (overlayEntry != null) return;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
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
              margin: const EdgeInsets.only(left: 44, top: 20.0, bottom: 17.32),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/home_icon.png',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 19.31,
              height: 23.81,
              margin: const EdgeInsets.only(top: 20.0, bottom: 17.32),
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
              margin: const EdgeInsets.only(top: 20.0, bottom: 17.32),
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
                icon: Image.asset(
                  'assets/images/add_icon.png',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 21.95,
              height: 24.21,
              margin: const EdgeInsets.only(top: 20.0, bottom: 17.32, right: 43.92),
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
          ],
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry!);
}
//현재 화면에서 뒤로가기
class WriteErrand extends StatefulWidget {
  WriteErrand({super.key});
  @override
  _WriteErrandState createState() => _WriteErrandState();
}
class ErrandRequest {
  final String? createdDate;
  final String? title;
  final String? destination;
  final double latitude;
  final double longitude;
  final String? due;
  final String? detail;
  final int reward;
  final bool isCash;
  ErrandRequest({
    required this.createdDate,
    required this.title,
    required this.destination,
    required this.latitude,
    required this.longitude,
    required this.due,
    required this.detail,
    required this.reward,
    required this.isCash
  });

  Map<String, dynamic> toJson(){
    return {
      "createdDate" : createdDate,
      "title" : title,
      "destination" : destination,
      "latitude" : latitude,
      "longitude" : longitude,
      "due" : due,
      "detail" : detail,
      "reward" : reward,
      "isCash" : isCash
    };
  }
}

class ReturnValues {
  final NLatLng value;
  final double zoom;

  ReturnValues({required this.value, required this.zoom});
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _WriteErrandState extends State<WriteErrand> {
  final int maxTitleLength = 20; // 제목 최대 길이 설정

  TextEditingController titleController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  // 텍스트 필드 변수 선언
  bool isTitleEnabled = false;
  bool isDetailAddressEnabled = false;
  bool isPriceEnabled = false;
  bool isRequestEnabled = false;

  // 일정 토글 버튼 변수 선언
  bool isToday = true; // 맨 처음 고정 값
  bool isTomorrow = false;
  bool isDetailVisible = true; // 예약 버튼 클릭 시 상세 시간 설정
  late List<bool> isSelected1 = [isToday, isTomorrow];

  // 위 두 변수를 닮을 리스트 -> 토글 버튼 위젯의 토글 선택 여부 담당

  // 일정 상세 시간 변수 선언
  int _selectedHour = 0; // 선택된 시간 저장
  int _selectedMinute = 0; // 선택된 분 저장

  // 결제 방법 토글 버튼 변수 선언
  bool isAccountTransfer = true; // 계좌이체
  bool isCash = false; // 현금
  late List<bool> isSelected2 = [isAccountTransfer, isCash];
  late NLatLng myLatLng; // 사용자의 위치 -> 위도 경도
  late NMarker marker; // 사용자의 위치를 받아온 초기 마커 위치

  NOverlayImage destIcon = NOverlayImage.fromAssetImage("assets/images/map_dest.png");
  double zoom = 14.5;

  NLatLng value = NLatLng(0, 0);
  late NaverMapController mapController; // 지도 컨트롤

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
  void errandPostRequest() async {
    log("작성완료 request");
    late ErrandRequest errand;
    errand = ErrandRequest(
        createdDate: DateTime.now().toString(),
        title: titleController.text,
        destination: detailAddressController.text,
        latitude: value.latitude,
        longitude: value.longitude,
        due: setDue(),
        detail: requestController.text,
        reward: int.parse(priceController.text),
        isCash: isSelected2[1],
    );
    log(setDue());
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand";
    String? token = await storage.read(key: 'TOKEN');
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(errand.toJson()),
          headers: {"Authorization": "$token",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        int errandNo = jsonDecode(response.body)['errandNo'];
        _insertOverlay(context);
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => MainErrandCheck(errandNo: errandNo,)
            ),);
      }
      else {
        print("ERROR : ");
        print(jsonDecode(response.body));
      }
    } catch(e) {
      log(e.toString());
    }
  }
  String setDue() {
    DateTime now = DateTime.now();
    if(isSelected1[1]) // 내일 선택
      now = now.add(Duration(days : 1)); // 다음 날이므로, 1일 추가
    DateTime due = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedHour,
        _selectedMinute
    );
    return due.toString();
  }

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    });
    titleController.addListener(updateTitleState);
    detailAddressController.addListener(updateDestinationState);
    priceController.addListener(updatePriceState);
    requestController.addListener(updateRequestState);
    getCurrentLocation().then((position) {
      setState(() {
        myLatLng = NLatLng(position.latitude, position.longitude);
        value = myLatLng;
        marker = NMarker(
          id: "test",
          position: myLatLng,
        );
        marker.setIcon(destIcon);
      });
    });
    // destinationValue = widget.value;
    //myLatLng = NLatLng(35.134384930841364, 129.10592409493796); // 자신의 위치
    // marker = NMarker(
    //   id: "test",
    //   position: myLatLng,
    //   // icon: markerIcon,
    // );
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    titleController.dispose();
    detailAddressController.dispose();
    priceController.dispose();
    requestController.dispose();
    super.dispose();
  }

  // 닉네임 확인
  void updateTitleState() {
    // 중복확인 입력란의 텍스트 변경 감지하여 이메일 전성 버튼의 활성화 상태 업데이트
    setState(() {
      isTitleEnabled = titleController.text.isNotEmpty;
    });
  }

  void updateDestinationState() {
    setState(() {
      isDetailAddressEnabled = detailAddressController.text.isNotEmpty;
    });
  }

  void updatePriceState() {
    // 비밀번호 확인 입력란의 텍스트 변경 감지하여 확인 버튼의 활성화 상태 업데이트
    setState(() {
      isPriceEnabled = priceController.text.isNotEmpty;
    });
  }

  void updateRequestState() {
    // 비밀번호 확인 입력란의 텍스트 변경 감지하여 확인 버튼의 활성화 상태 업데이트
    setState(() {
      isRequestEnabled = requestController.text.isNotEmpty;
    });
  }

  void toggleSelect1(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected1.length; index++) {
        if (index == newindex) {
          isSelected1[index] = true;
        } else {
          isSelected1[index] = false;
        }
      }
    });
    //print(isSelected1);
  }

  void toggleSelect2(int newindex) {
    setState(() {
      for (int index = 0; index < isSelected2.length; index++) {
        if (index == newindex) {
          isSelected2[index] = true;
        } else {
          isSelected2[index] = false;
        }
      }
    });
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
      child: Scaffold(
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
                        '요청서 작성하기',
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
                Container(
                  margin: EdgeInsets.only(top: 34),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            '제목',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 0.01,
                              color: Color(0xff111111),
                            ),
                          ),
                        ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 300),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xffF05252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //제목 텍스트 필드
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0),
                  width: 318,
                  height: 31,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xff2D2D2D), // 테두리 색상
                        width: 0.5 // 테두리 굵기
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    color: Color(0xffFFFFFF), // 텍스트 필드 배경색
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 7.5, left: 10, right: 10),
                    child: TextField(
                      maxLength: maxTitleLength,
                      controller: titleController,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: 0.01,
                        color: Color(0xff252525),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),

                // 일정 텍스트
                Container(
                  margin: EdgeInsets.only(top: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            '일정',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.01,
                              color: Color(0xff111111),
                            ),
                          ),
                        ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xffF05252),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 121),
                    //   child: Text(
                    //     '예약은 최대 ?시간 이후까지 가능해요.',
                    //     style: TextStyle(
                    //       fontFamily: 'Pretendard',
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 12,
                    //       letterSpacing: 0.01,
                    //       color: Color(0xff111111),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 6, left: 22),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 106,
                          height: 38,
                          // 토글 버튼 만들기
                          margin: EdgeInsets.only(left: 0),
                          child: ToggleButtons(
                            color: Color(0xff2E2E2E),
                            // 선택되지 않은 버튼 텍스트 색상
                            // 선택되지 않은 버튼 배경색
                            borderColor: Colors.grey,
                            // 토글 버튼 테두리 색상
                            borderWidth: 0.5,
                            borderRadius: BorderRadius.circular(5.0),

                            selectedColor: Color(0xffC77749),
                            // 선택된 버튼 텍스트 색상
                            fillColor: Color(0xffFFFFFF),
                            // 선택된 버튼 배경색
                            selectedBorderColor: Color(0xffC77749),
                            // 선택된 버튼 테두리 색상

                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '오늘',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    letterSpacing: 0.01,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '내일',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    letterSpacing: 0.01,
                                  ),
                                ),
                              ),
                            ],
                            isSelected: isSelected1,
                            onPressed: toggleSelect1,
                          ),
                        ),
                      ),
                      if (isDetailVisible)
                      // 시간 상세 설정 카테고리
                        Container(
                          margin: EdgeInsets.only(right: 51),
                          width: 165.28,
                          height: 38,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffA9A9A9), // 박스 테두리 색상
                              width: 0.5, // 테두리 굵기
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Color(0xffFFFFFF), // 박스 배경 색상
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: DropdownButton<int>(
                                  underline: Container(),
                                  // dropdownButton 밑줄 제거
                                  value: _selectedHour,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _selectedHour = newValue!;
                                      log(_selectedHour.toString());
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      size: 17, color: Color(0xff808080)),
                                  items: List.generate(24, (index) {
                                    // 0~23시
                                    return DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        '$index',
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          letterSpacing: 0.01,
                                          color: Color(0xffC77749),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  '시',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    letterSpacing: 0.01,
                                    color: Color(0xff4F4F4F),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: DropdownButton<int>(
                                  underline: Container(),
                                  // dropdownButton 밑줄 제거
                                  value: _selectedMinute,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _selectedMinute = newValue!;
                                      log(_selectedMinute.toString());
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      size: 17, color: Color(0xff808080)),
                                  items: List.generate(60, (index) {
                                    // 0~59분
                                    return DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        '$index',
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          letterSpacing: 0.01,
                                          color: Color(0xffC77749),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 2),
                                child: Text(
                                  '분',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    letterSpacing: 0.01,
                                    color: Color(0xff4F4F4F),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  '까지',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    letterSpacing: 0.01,
                                    color: Color(0xffC77749),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                // 도착지 텍스트
                Container(
                  margin: EdgeInsets.only(top: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            '도착지',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.01,
                              color: Color(0xff111111),
                            ),
                          ),
                        ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 289),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xffF05252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 네이버 미니 지도
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
                        scrollGesturesEnable: false, // 스크롤 비활성화
                        zoomGesturesEnable: false, // 줌 비활성화

                        // locationButtonEnable: true, // 내 위치 버튼 활성화
                        logoClickEnable: false, // 네이버 로고 클릭 비활성화

                        mapType: NMapType.basic, // 지도 유형 : 기본 지도(기본 값)
                        activeLayerGroups: [ // 표시할 정보
                          NLayerGroup.building, // 건물 레이어
                          NLayerGroup.transit, // 대중교통 레이어
                        ],
                        initialCameraPosition: NCameraPosition(
                            target: myLatLng,// 내 위치
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
                          MaterialPageRoute(builder: (context) => NaverMapTest(value: value, zoom: zoom)),
                        );
                        // log(point.toString());
                        // log(latLng.toString());

                        setState(() {
                          value = returnValue.value;
                          zoom = returnValue.zoom;
                          marker.setPosition(value);
                          marker.setIsVisible(true); // 새로운 값이 들어오면 마커 다시 보이도록 설정
                        });
                        mapController.updateCamera(
                          NCameraUpdate.scrollAndZoomTo(
                            target : NLatLng(value.latitude, value.longitude),
                            zoom: zoom,
                          ),
                        );
                      },

                      onSymbolTapped: (symbol) {
                        setState(() {
                          marker.setPosition(value);  // marker 위치 이동
                          marker.setIsVisible(true);
                        });
                        final cameraPosition = NCameraPosition(
                            target: NLatLng(value.latitude, value.longitude),
                            zoom: zoom
                        );
                        final cameraUpdate = NCameraUpdate.fromCameraPosition(cameraPosition);
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
                // 상세 주소 텍스트 필드
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 7.0),
                  width: 320,
                  height: 38,
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.75, left: 12.6, right: 8),
                    child: TextField(
                      controller: detailAddressController,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: 0.01,
                        color: Color(0xff373737),
                      ),
                      decoration: InputDecoration(
                        hintText: '상세 주소를 입력해주세요. ex) 중앙도서관 1층 데스크',
                        hintStyle: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          letterSpacing: 0.01,
                          color: Color(0xff878787),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),

                // 심부름 값 텍스트, 결제 방법 텍스트
                Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            '심부름 값',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.01,
                              color: Color(0xff111111),
                            ),
                          ),
                        ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 70),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xffF05252),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        child: Text(
                          '결제 방법',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 142),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xffF05252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 심부름 값 텍스트 필드, 결제 방법 토글 버튼
                Container(
                  margin: EdgeInsets.only(top: 6, left: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        // 심부름 값 텍스트 필드
                        child: Container(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Container(
                                width: 107,
                                height: 38,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff2D2D2D),
                                      width: 0.5 // 테두리 굵기
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                  color: Color(0xffFFFFFF),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 4, left: 27, right: 7.5),
                                  child: TextField(
                                    controller: priceController,
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
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12.36, top: 1),
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/images/₩.png',
                                      color: Color(0xff7C7C7C),
                                      width: 11,
                                      height: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 119,
                        height: 38,
                        // 토글 버튼 만들기
                        margin: EdgeInsets.only(right: 86),
                        child: ToggleButtons(
                          color: Color(0xff2E2E2E),
                          // 선택되지 않은 버튼 텍스트 색상

                          borderColor: Colors.grey,
                          // 토글 버튼 테두리 색상
                          borderWidth: 0.5,
                          borderRadius: BorderRadius.circular(5.0),

                          selectedColor: Color(0xffC77749),
                          // 선택된 버튼 텍스트 색상
                          fillColor: Color(0xffFFFFFF),
                          // 선택된 버튼 배경색
                          selectedBorderColor: Color(0xffC77749),
                          // 선택된 버튼 테두리 색상

                          // renderBorder: false,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 11),
                              child: Text(
                                '계좌이체',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  letterSpacing: 0.01,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                '현금',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  letterSpacing: 0.01,
                                ),
                              ),
                            ),
                          ],
                          isSelected: isSelected2,
                          onPressed: toggleSelect2,
                        ),
                      ),
                    ],
                  ),
                ),

                // 요청사항 텍스트
                Container(
                  margin: EdgeInsets.only(top: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            '요청사항',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.01,
                              color: Color(0xff111111),
                            ),
                          ),
                        ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 275),
                        child: Text(
                          '*',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xffF05252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 요청사항 텍스트 필드
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0),
                  width: 318,
                  height: 66.56,
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Color(0xff2D2D2D), width: 0.5 // 테두리 굵기
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2, left: 10, right: 10),
                    // hintText Padding이 이상해서 임의로 설정
                    child: TextField(
                      controller: requestController,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: 0.01,
                        color: Color(0xff111111),
                      ),
                      decoration: InputDecoration(
                        hintText:
                        '심부름 내용에 대한 간단한 설명을 적어주세요.\nex) 한 잔만 시럽 2번 추가해 주세요.',
                        hintStyle: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          letterSpacing: 0.01,
                          color: Color(0xff878787),
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      // 입력 텍스트가 필요한 만큼 자동으로 늘어남
                      minLines: 1,
                      // 최소한 1줄 표시
                      keyboardType: TextInputType.multiline, // 여러 줄 입력 가능하도록 하기
                    ),
                  ),
                ),
                // 작성 완료 버튼 만들기
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.27),
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      errandPostRequest();
                    },
                    style: ButtonStyle(
                      // 버튼의 배경색 변경하기
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (isTitleEnabled &&
                                isDetailAddressEnabled &&
                                isPriceEnabled &&
                                isRequestEnabled) {
                              return Color(
                                  0xFF7C3D1A); // 활성화된 배경색(모든 텍스트 필드 비어있지 않은 경우)
                            } else {
                              return Color(
                                  0xFFBD9E8C); // 비활성화 배경색(하나의 텍스트 필드라도 비어있는 경우)
                            }
                          }),
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
                      '작성 완료',
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
      ),
    );

  }
}
