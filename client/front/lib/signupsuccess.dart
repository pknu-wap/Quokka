import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Signup_Success extends StatelessWidget {
  const Signup_Success({Key? key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        body: Stack(
          children: [
            Container(
              width: 269.64,
              height: 396.95,
              margin: EdgeInsets.only(left: 10.0, top: 79.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/firework.png'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 58.86, top: 387),
              child: Transform.rotate(
                angle: 4.73 * (3.141592653589793 / 180),
                child: Image.asset('assets/Subtract.png',width: 67.5, height: 95.43,),
              ),
            ),
            Container(
              width: 179.02,
              height: 49.96,
              margin: EdgeInsets.only(left:90.49, top: 239.88),
              child: Text('환영합니다!\n가입이 완료되었습니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pretendard',fontSize: 18, fontWeight: FontWeight.w600,
                  letterSpacing: 0.01, color: Color(0xff000000),
                ),),)
          ],),
      ),
    );
  }}
