import 'dart:async';
import 'dart:developer';
// import 'dart:js_interop';
import 'package:flutter/material.dart'; // icon 사용하기 위해 필요
import 'package:flutter/widgets.dart'; // text컨트롤러 사용하기 위해 필요
import 'package:flutter_naver_map/flutter_naver_map.dart';

void map() async {
  await initializeNaverMapSdk(); // 네이버 지도 SDK 초기화
  runApp( Map());
}

Future<void> initializeNaverMapSdk() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 네이버 지도 SDK 초기화
  await NaverMapSdk.instance.initialize(
    clientId: 'a2gzk9vug1',
    onAuthFailed: (ex) => print("네이버 지도 인증 오류: $ex"),
  );
}

class Map extends StatelessWidget {
  // const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      home: NMap()
    );
  }
}

class NMap extends StatefulWidget {
  const NMap({super.key});

  @override
  State<NMap> createState() => _NMapState();
}

class _NMapState extends State<NMap> {
  final NCameraPosition position = NCameraPosition(
      target: NLatLng(35.13354860000066, 129.10231956595868),
      zoom: 12
  );
  // 뷰포트 -> Latitude : 위도(38), Longitude : 경도(127) -> 처음 시작 위치
  // https://map.naver.com/p/entry/place/12104897?c=15.19,0,0,0,dh
  // 위도 : 35.13354860000066
  // 경도 : 129.10231956595868
  // 주소 : 부산 남구 대연동 430-1 => 부경대학교 대연캠퍼스

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("도착지 검색"),
      ),
      body: Container(
          child: NaverMap(
          ),
      ),
    );
  }
}

// void map() async{
//   await _initialize();
//   runApp(const NaverMapApp());
// }
//
// Future<void> _initialize() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NaverMapSdk.instance.initialize( // 네이버 지도 SDK 초기화 확인
//     clientId: '<a2gzk9vug1>', // 클라이언트 ID 설정
//     onAuthFailed: (ex) => log("네이버 지도 인증 오류 : $ex")
//   );
// }
//
// class NaverMapApp extends StatelessWidget {
//   final int? testId;
//
//   const NaverMapApp({super.key, this.testId});
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//       home: testId == null
//           ? const FirstPage()
//           : TestPage(key: Key("testPage_$testId")));
// }
//
// class FirstPage extends StatelessWidget {
//   const FirstPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('First Page')),
//         body: Center(
//             child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const TestPage()));
//                 },
//                 child: const Text('Go to Second Page'))));
//   }
// }
//
// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   State<TestPage> createState() => TestPageState();
// }
//
// class TestPageState extends State<TestPage> {
//   late NaverMapController _mapController;
//   final Completer<NaverMapController> mapControllerCompleter = Completer();
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final pixelRatio = mediaQuery.devicePixelRatio;
//     final mapSize =
//     Size(mediaQuery.size.width - 32, mediaQuery.size.height - 72);
//     final physicalSize =
//     Size(mapSize.width * pixelRatio, mapSize.height * pixelRatio);
//
//     print("physicalSize: $physicalSize");
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF343945),
//       body: Center(
//           child: SizedBox(
//               width: mapSize.width,
//               height: mapSize.height,
//               // color: Colors.greenAccent,
//               child: _naverMapSection())),
//     );
//   }
//
//   Widget _naverMapSection() => NaverMap(
//     options: const NaverMapViewOptions(
//         indoorEnable: true,
//         locationButtonEnable: false,
//         consumeSymbolTapEvents: false),
//     onMapReady: (controller) async {
//       _mapController = controller;
//       mapControllerCompleter.complete(controller);
//       log("onMapReady", name: "onMapReady");
//     },
//   );
// }



// class NaverMap extends StatefulWidget {
//   @override
//   _NaverMapState createState() => _NaverMapState();
// }
//
// // 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
// class _NaverMapState extends State<NaverMap> {
//   TextEditingController destinationController = TextEditingController();
//
//
//   bool isDestinationEnabled = false;  // 텍스트 필드 변수 선언
//   bool isCompletedEnabled = false; // 도착지로 설정할게요 버튼
//
//   @override
//   void initState() {
//     // 위젯의 초기 상태 설정 = 상태 변화 감지
//     super.initState();
//     destinationController.addListener(updateDestinationState);
//   }
//
//   @override
//   void dispose() {
//     // 위젯이 제거될 때 호출됨
//     destinationController.dispose();
//     super.dispose();
//   }
//
//   void updateDestinationState() {
//     setState(() {
//       isDestinationEnabled = destinationController.text.isNotEmpty;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: const Text('NaverMap Test')),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 19.0, top: 34.0),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.arrow_back_ios),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     Text(
//                       '도착지 찾기',
//                       style: TextStyle(
//                         fontFamily: 'Paybooc',
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff111111),
//                         fontSize: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 34),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         margin: EdgeInsets.only(left: 24),
//                         child: Text(
//                           '제목',
//                           style: TextStyle(
//                             fontFamily: 'Pretendard',
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             letterSpacing: 0.01,
//                             color: Color(0xff111111),
//                           ),
//                         ),
//                       ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(right: 300),
//                       child: Text(
//                         '*',
//                         style: TextStyle(
//                           fontFamily: 'Pretendard',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14,
//                           letterSpacing: 0.01,
//                           color: Color(0xffF05252),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // 도착지로 설정할게요 버튼 만들기
//               Container(
//                 margin: EdgeInsets.only(left: 20.0, right: 21.0, top: 110.6),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print("도착지 설정 완료");
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         Color(0xFF7C3D1A)),
//                     // 버튼의 크기 정하기
//                     minimumSize: MaterialStateProperty.all<Size>(Size(318, 41)),
//                     // 버튼의 모양 변경하기
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                             5), // 원하는 모양에 따라 BorderRadius 조절
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     '도착지로 설정할게요',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Pretendard',
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFFFFFFFF),
//                     ),
//                   ),
//                 ),
//               ),
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
