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
import 'package:gif/gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  FlutterNativeSplash.remove();
  await dotenv.load(fileName: 'assets/env/.env');

  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['CLIENT_ID'] ?? '',
    onAuthFailed: (ex) {
      print("********* 네이버맵 인증오류 : $ex *********");
    },
  );

  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late Future<bool> _tokenCheckFuture;
  @override
  void initState() {
    super.initState();
    _tokenCheckFuture = Check_Token();
  }

  Future<bool> Check_Token() async {
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/token/isValid";
    String? token = await storage.read(key: 'TOKEN');
    print(token);
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
        print(response.statusCode);
    if (response.statusCode == 200) {
      print("200 ok at main.dart");
      return true;
      // Navigator.of(context).push(
      //   //토큰이 타당하면 바로 게시글 페이지로 넘어감
      //     MaterialPageRoute(builder: (context) => Home()));
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 760),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Main',
          home: FutureBuilder(
            future: _tokenCheckFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else {
                FlutterNativeSplash.remove();
                bool isValid = snapshot.data ?? false;
                return AppLoad(isValid: isValid);
              }
            },
          ),
        );
      }
    );
  }
}
class AppLoad extends StatefulWidget {
  final bool isValid;
  AppLoad({Key? key, required this.isValid}) : super(key: key);

  @override
  _AppLoadState createState() => _AppLoadState();
}

class _AppLoadState extends State<AppLoad> with SingleTickerProviderStateMixin {
  late final GifController controller;

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAppLoadAnimation(widget.isValid);
    });
  }

  void _startAppLoadAnimation(bool isValid) async {
    await Future.delayed(Duration(seconds: 4));
    if (mounted) {
      if (isValid) {
        print("valid : true");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
      else {
        print("valid : false");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogIn()),
        );
      }
    }
  }
  @override
  void dispose() {
    controller.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Gif(
            image: AssetImage('assets/images/loading_app_gif.gif'),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            controller: controller,
            duration: Duration(seconds: 3),
            autostart: Autostart.once,
          ),
        ),
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


// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
//
// import 'login.dart';
// import 'home.dart';
//
// final storage = FlutterSecureStorage();
//
// void main() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   Future<void> checkToken(BuildContext context) async {
//     String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/token/isValid";
//     String? token = await storage.read(key: 'TOKEN');
//     print(token);
//     var response = await http.get(Uri.parse(url),
//         headers: {"Authorization": "$token"});
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print("200 ok at main.dart");
//       FlutterNativeSplash.remove();
//       Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => Home()));
//     } else {
//       FlutterNativeSplash.remove();
//       Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => LogIn()));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Main',
//       home: SplashScreen(),
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   int _currentIndex = 0;
//   late Timer _timer;
//
//   final List<String> _images = [
//     'assets/images/loading_quokka_sort_x4.png',
//     'assets/images/loading_quokka_right_x4.png',
//     'assets/images/loading_quokka_left_x4.png',
//     'assets/images/quokka2_x4.png',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     startImageRotation();
//     navigateToNextScreen();
//   }
//
//   void startImageRotation() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _currentIndex = (_currentIndex + 1) % _images.length;
//       });
//     });
//   }
//
//   Future<void> navigateToNextScreen() async {
//     await Future.delayed(Duration(seconds: 3));
//     // checkToken(context);
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffFFFFFF),
//       body: Center(
//         child: Image.asset(
//           _images[_currentIndex],
//           width: 96.43,
//           height: 124.24,
//         ),
//       ),
//     );
//   }
// }