import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              leading:
              Padding(padding: EdgeInsets.only(top: 26.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    print('back button is clicked');
                  },
                ),
              ),
              title: Padding(padding: EdgeInsets.only(top: 26.0),
                  child: SizedBox(
                    height: 25.0,
                    child:
                    Text('본인인증', style: TextStyle(
                      fontFamily: 'paybooc',fontSize: 20,
                      letterSpacing: 0.01, color: Color(0xff111111),
                    )),
                  ))),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Container(
                  margin: EdgeInsets.only(left: 22.0, top: 30.0),
                  child: Text('모바일 학생증 인증', style: TextStyle(
                    fontFamily: 'Pretendard',fontSize: 14, fontWeight: FontWeight.bold,
                    letterSpacing: 0.01, color: Color(0xff373737),))),
                Container(margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/images/Rectangle 1.png',width: 320, height: 202, fit : BoxFit.cover),
                      Positioned(
                        left: 0, right: 0, top: 0, bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.add,size: 100,color: Color(0xff8D8D8D),),

                          onPressed: () {
                            print('add button is clicked');
                          },
                        ),
                      ),
                    ],
                  ),),

                SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 22.0, top: 36.0),
                          child: Row(
                            children: [
                              Container( margin: EdgeInsets.only(right: 9.0,),
                                child: Text('업로드 파일 예시', style: TextStyle(
                                  fontFamily: 'Pretendard',fontSize: 14, fontWeight: FontWeight.bold,
                                  letterSpacing: 0.01, color: Color(0xff373737),)),),
                              Text('파일 형식  jpg / png', style: TextStyle(
                                fontFamily: 'Pretendard',fontSize: 12,
                                letterSpacing: 0.01, color: Color(0xff373737),)),
                            ],
                          ),),
                        Container(
                          width: 139.58, height: 256.44,
                          margin: EdgeInsets.only(left: 22.0, top: 18.0),
                          child: Image.asset('assets/images/IMG_8528 1.png',),)
                      ],
                    )
                )
              ],
            ),
          ),
        )
    );
  }}