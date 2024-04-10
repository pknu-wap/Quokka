import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Check_Image extends StatelessWidget {
  const Check_Image({Key? key}): super (key: key);

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
                    Navigator.of(context).pop();
                  },
                ),
              ),
              title: Padding(padding: EdgeInsets.only(top: 26.0),
                  child: SizedBox(
                    height: 25.0,
                    child:
                    Text('회원가입', style: TextStyle(
                      fontFamily: 'paybooc',fontSize: 20,
                      letterSpacing: 0.01, color: Color(0xff111111),
                    )),
                  ))),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Container(
                  margin: EdgeInsets.only(left: 24.0, top: 30.0),
                  child: Text('학부 / 학과', style: TextStyle(
                    fontFamily: 'Pretendard',fontSize: 14, fontWeight: FontWeight.bold,
                    letterSpacing: 0.01, color: Color(0xff373737),))),
                Container(margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                  child: TextField(
                    decoration: InputDecoration(
                      /* labelText: '학번',*/
                      hintText: '시각디자인학과',
                      filled: true,
                      fillColor: Colors.grey[300],
                      labelStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none, // 테두리 없애기
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),  // 학번 텍스트 입력 구현(누르면 글자 사라짐)
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
                          child: Image.asset('assets/upload_image_sample.png',),)
                      ],
                    )
                )
              ],
            ),
          ),
        )
    );
  }}