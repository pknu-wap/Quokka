// 현재 화면 로딩중 표시로 3초 기다렸다가 login.dart페이지로 넘어가게 되어있음 -> 추후 main.dart 페이지도 보이도록 할 예정
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'main_post_page.dart';
final storage = FlutterSecureStorage();
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Check_Token(BuildContext context) async {
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/token/isValid";
    String? token = await storage.read(key: 'TOKEN');
    print(token);
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
        print(response.statusCode);
    if (response.statusCode == 200) {
      print("200 ok");
      Navigator.of(context).push(
        //토큰이 타당하면 바로 게시글 페이지로 넘어감
          MaterialPageRoute(builder: (context) => Main_post_page()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Main',
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          Check_Token(context);
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
}
