import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 환경변수 .env 로드
import 'package:kakao_map_plugin/kakao_map_plugin.dart'; // Kakao map

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');

  // 앱 초기화 시점에 필요한 설정을 수행합니다.
  late String appKey = dotenv.env['APP_KEY'] ?? '';

  // @override
  // void initState() {
  //   super.initState();
  //   appKey = '0f07f39ac1feda9399b1e274406fe695';       // 초기화 오류 발생해서 appKey가 .env파일에서 안 불러와지나 싶어서 여기서 바로 적어봤는데도 오류가 발생함.
  // }

  AuthRepository.initialize(
    appKey: dotenv.env['APP_KEY'] ?? '',
    baseUrl: dotenv.env['BASE_URL'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakao Map Test',
      home: KakaoMapTest(),
    );
  }
}

class KakaoMapTest extends StatefulWidget {
  const KakaoMapTest({Key? key}) : super(key: key);

  @override
  State<KakaoMapTest> createState() => _KakaoMapTestState();
}

class _KakaoMapTestState extends State<KakaoMapTest> {
  @override
  void initState() {
    super.initState();
    // 필요한 초기화 작업을 수행합니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kakao Map Test'),
      ),
      body: const KakaoMap(),
    );
  }
}


// import 'package:flutter_dotenv/flutter_dotenv.dart'; // 환경변수 로드하기
// import 'package:flutter/material.dart'; // icon 사용하기 위해 필요
// import 'package:flutter/widgets.dart'; // text컨트롤러 사용하기 위해 필요
// import 'package:flutter_kakao_maps_sdk/flutter_kakao_maps_sdk.dart';
// import 'package:kakao_map_plugin/kakao_map_plugin.dart';
//
// void map() {
//   runApp(Map(appKey:));
// }
//
// class Map extends StatelessWidget {
//   final String appKey; // late 키워드를 사용하여 나중에 초기화될 것임을 선언
//   // const Map({super.key});
//   Map({Key? key, required this.appKey});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'KaKao Map',
//       home: KakaoMapTest(),
//     );
//   }
// }
//
// class KakaoMapTest extends StatefulWidget {
//   const KakaoMapTest({super.key});
//
//   @override
//   State<KakaoMapTest> createState() => _KakaoMapTestState();
// }
//
// class _KakaoMapTestState extends State<KakaoMapTest> {
//   TextEditingController mapController = TextEditingController();
//   // 뷰포트 -> Latitude : 위도(38), Longitude : 경도(127) -> 처음 시작 위치
//   // https://map.naver.com/p/entry/place/12104897?c=15.19,0,0,0,dh
//   // 위도 : 35.13354860000066
//   // 경도 : 129.10231956595868
//   // 주소 : 부산 남구 대연동 430-1 => 부경대학교 대연캠퍼스
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("도착지 검색"),
//     ),
//       body: KakaoMap(
//         // onMapCreated: ((controller) {
//         //   mapController = controller;
//         // }),
//       ),
    //   Column(
    //   children: [
    //   // 도착지로 설정할게요 버튼 만들기
    //           Container(
    //             margin: EdgeInsets.only(left: 20.0, right: 21.0, top: 110.6),
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 print("도착지 설정 완료");
    //               },
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all<Color>(
    //                     Color(0xFF7C3D1A)),
    //                 // 버튼의 크기 정하기
    //                 minimumSize: MaterialStateProperty.all<Size>(Size(318, 41)),
    //                 // 버튼의 모양 변경하기
    //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                   RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(
    //                         5), // 원하는 모양에 따라 BorderRadius 조절
    //                   ),
    //                 ),
    //               ),
    //               child: Text(
    //                 '도착지로 설정할게요',
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                   fontFamily: 'Pretendard',
    //                   fontWeight: FontWeight.w600,
    //                   color: Color(0xFFFFFFFF),
    //                 ),
    //               ),
    //             ),
    //           ),
    // ],
    //   ),
//     );
//   }
// }





// class KakaoMapTest extends StatefulWidget {
//   @override
//   _KakaoMapTestState createState() => _KakaoMapTestState();
// }
//
// // 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
// class _KakaoMapTestState extends State<KakaoMapTest> {
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
//       // appBar: AppBar(title: const Text('KakaoMapTestTest')),
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
//                       ),
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
