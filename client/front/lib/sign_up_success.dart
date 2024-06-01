import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'login.dart';
import 'errand/main_post_page.dart';
import 'package:http/http.dart' as http;

class Signup_Success extends StatelessWidget {
  final String username;
  final String pw;
  const Signup_Success({Key? key, required this.username, required this.pw}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Padding(padding: EdgeInsets.only(top: 26.0),
                child: SizedBox(
                  height: 25.0,
                  child:
                  Text('가입완료', style: TextStyle(
                    fontFamily: 'paybooc',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.01,
                    color: Color(0xff111111),
                  )),
                ))),
        body: Confetti(username: username, pw : pw),
      ),
    );
  }}
class Confetti extends StatefulWidget {
  final String username;
  final String pw;
  const Confetti({required this.username, required this.pw});
  @override
  ConfettiState createState() => ConfettiState();
}

class ConfettiState extends State<Confetti> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
    Timer(Duration(seconds: 5), () { //3초는 폭죽 감상하기에 너무 짧은거 같애서 5초로 했는데 폭죽이 더 빨리 나오게 만들고 수정할게요
      getTokenAndLogin();
    });
  }

  void getTokenAndLogin() async{
    String base_url = dotenv.env['BASE_URL'] ?? '';
    String url = "${base_url}login";
    String param = "?username=${widget.username}&password=${widget.pw}";
    print(url+param);
    try {
      var post = await http.post(Uri.parse(url + param));
      if (post.statusCode == 200) {
        Map<String, dynamic> headers = post.headers;
        String? token = headers["authorization"];
        print("token: $token");
        await storage.write(key: 'TOKEN', value: token);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Main_post_page()));
      }
      else {
        log("response code != 200");
        log(post.body);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogIn()));
      }

    } catch(e) {
      log("exception !");
      log(e.toString());
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogIn()));
    }
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Path drawHeart(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();

    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: 269.64,
            height: 396.95,
            margin: EdgeInsets.only(left: 10.0, top: 79.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/firework.png'), // 배경 이미지
              ),
            ),
          ),
          // 회전된 이미지
          Positioned(
            left: 58.86,
            top: 387,
            child: Transform.rotate(
              angle: 4.73 * (3.141592653589793 / 180), //회전
              child: Image.asset('assets/images/Subtract.png', //폭죽 본체 이미지
                width: 67.5,
                height: 95.43,
              ),
            ),
          ),
          // 중앙에 위치한 ConfettiWidget
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              createParticlePath: drawHeart,
            ),
          ),
          // 텍스트 버튼
          Positioned(
            left: 90.49,
            top: 239.88,
            child: Container(
              width: 200.0,
              height: 70.0,
              child: TextButton(
                onPressed: () {
                  _controllerCenter.play();
                },
                child: Text('환영합니다!\n가입이 완료되었습니다',
                  textAlign: TextAlign.center, style: TextStyle(
                    fontFamily: 'Pretendard', fontSize: 18,
                    fontWeight: FontWeight.w600, letterSpacing: 0.01,
                    color: Color(0xff000000),
                  ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
