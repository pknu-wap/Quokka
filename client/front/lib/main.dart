// 현재 화면 로딩중 표시로 3초 기다렸다가 login.dart페이지로 넘어가게 되어있음 -> 추후 main.dart 페이지도 보이도록 할 예정
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'login.dart';
import 'upload_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');

  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['CLIENT_ID'] ?? '',
    onAuthFailed: (ex) {
      print("********* 네이버맵 인증오류 : $ex *********");
    },
  );

  // final markerIcon = await NOverlayImage.fromAssetImage(
  //   'assets/images/location.png',
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main',
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return LogIn(); // 로그인 페이지로 이동합니다.
          }
        },
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.only(top: 22.0),
        margin: EdgeInsets.only(top: 122), // 커카 이미지에 대한 마진 설정
        child: Center(
          child: Image(
            image: AssetImage('assets/images/image 6.png'),
            width: 170.0,
          ),
        ),
      ),
    );
  }
} // 로그인 기능 만듬.
