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
        body: Container(),
      ),
    );
  }}