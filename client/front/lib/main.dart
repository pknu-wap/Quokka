// 현재 화면 로딩중 표시로 3초 기다렸다가 login.dart페이지로 넘어가게 되어있음 -> 추후 main.dart 페이지도 보이도록 할 예정
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'home.dart';
final storage = FlutterSecureStorage();
// Future<bool> _determinePermission() async {
//   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.value(false);
//   }
//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if(permission == LocationPermission.denied){
//       return Future.value(false);
//     }
//   }
//   if (permission == LocationPermission.deniedForever){
//     return Future.value(false);
//   }
//   return Future.value(true);
// }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: 'assets/env/.env');

  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['CLIENT_ID'] ?? '',
    onAuthFailed: (ex) {
      print("********* 네이버맵 인증오류 : $ex *********");
    },
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  Check_Token(BuildContext context) async {
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/token/isValid";
    String? token = await storage.read(key: 'TOKEN');
    print(token);
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
        print(response.statusCode);
    if (response.statusCode == 200) {
      print("200 ok at main.dart");
      FlutterNativeSplash.remove();
      Navigator.of(context).push(
        //토큰이 타당하면 바로 게시글 페이지로 넘어감
          MaterialPageRoute(builder: (context) => Home()));
    }
  }

  Future<void> _checkToken() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main',
      home: FutureBuilder(
        future: _checkToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Check_Token(context);
            return Scaffold(
              backgroundColor: Color(0xffFFFFFF),
              body: Center(
                // child: CircularProgressIndicator(),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    // Image(
                    // image: AssetImage('assets/images/loding_quokka_sort.png'),
                    //   width: 96.43,
                    //   height: 124.24,
                    // ),
                  ],
                ),
              ),
            );
          }
          else {
            FlutterNativeSplash.remove();
            return LogIn(); // 로그인 페이지로 이동합니다.
          }
        },
      ),
    );
  }
}

// class Main extends StatefulWidget {
//   @override
//   State<Main> createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   void getLocation() async {
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     print(position);
//   }


  // @override
  // void initState() {
  //   super.initState();
  //   getGeoData();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       margin: EdgeInsets.only(top: 321, left: 131), // 커카 이미지에 대한 마진 설정
  //       child: Center(
  //         child: Image(
  //           image: AssetImage('assets/images/loding_quokka_sort.png'),
  //           width: 170.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }
