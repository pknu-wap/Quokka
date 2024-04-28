import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Main_post_page extends StatefulWidget {
  const Main_post_page({Key? key}) : super(key: key);
  @override
  _Main_post_pageState createState() => _Main_post_pageState();
}
class _Main_post_pageState extends State<Main_post_page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xffF6F6F6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container( width: 57.0, height: 25.0,
                      margin: const EdgeInsets.only(left: 27, top: 33.0),
                      child: const Text(
                        '게시글',
                        style: TextStyle(
                          fontFamily: 'paybooc',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.01,
                          color: Color(0xff111111),
                        ),),),
                    SizedBox(width: 158),
                    Container(
                      margin : const EdgeInsets.only(top: 35.0),
                      child: IconButton(
                        onPressed:
                            () {},
                        icon: Image.asset('assets/images/search_icon.png',
                        ),
                      ),
                    ),
                    Container(
                      margin : const EdgeInsets.only(top: 34.0,right: 21.31),
                      child: IconButton(
                        onPressed: () {
                        },
                        icon: Image.asset('assets/images/alarm_icon.png',
                          color: Color(0xffB4B5BE),
                        ),
                      ),)
                  ],
                )
               ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 버튼 클릭 시 실행될 동작
                      },
                      child: Container(width: 70, height: 32,
                        margin: const EdgeInsets.only(left: 27, top: 19.0),
                        child: Stack(
                          children: [
                            Positioned(left: 0, top: 0,
                              child: Container(width: 70, height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  border: Border.all(color: Color(0xFF7C3D1A), width: 1,),
                                  borderRadius: BorderRadius.circular(10),
                                ),),), // Text
                            Positioned(left: 16.72, top: 7.72,
                              child: Text('최신순', style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500, fontSize: 14,
                                  letterSpacing: 0.001, color: Color(0xFF7C2E1A),
                                ),),),
                          ],),),),
                    GestureDetector(
                      onTap: () {
                        // 버튼 클릭 시 실행될 동작
                      },
                      child: Container(width: 70, height: 32,
                        margin: const EdgeInsets.only(left: 11, top: 19.0),
                        child: Stack(
                          children: [
                            Positioned(left: 0, top: 0,
                              child: Container(width: 70, height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  border: Border.all(color: Color(0xFFB1B1B1), width: 1,),
                                  borderRadius: BorderRadius.circular(10),
                                ),),), // Text
                            Positioned(left: 16.72, top: 7.72,
                              child: Text('금액순', style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 14,
                                letterSpacing: 0.001, color: Color(0xFF4A4A4A),
                              ),),),
                          ],),),),
                    GestureDetector(
                      onTap: () {
                        // 버튼 클릭 시 실행될 동작
                      },
                      child: Container(width: 70, height: 32,
                        margin: const EdgeInsets.only(left: 11, top: 19.0),
                        child: Stack(
                          children: [
                            Positioned(left: 0, top: 0,
                              child: Container(width: 70, height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  border: Border.all(color: Color(0xFFB1B1B1), width: 1,),
                                  borderRadius: BorderRadius.circular(10),
                                ),),), // Text
                            Positioned(left: 16.72, top: 7.72,
                              child: Text('거리순', style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 14,
                                letterSpacing: 0.001, color: Color(0xFF4A4A4A),
                              ),),),
                          ],),),)
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 22.0, top: 36.0),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 9.0),
                            child: const Text(
                              '업로드 파일 예시',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.01,
                                color: Color(0xff373737),
                              ),
                            ),
                          ),
                          const Text(
                            '파일 형식  jpg / png',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 12,
                              letterSpacing: 0.01,
                              color: Color(0xff373737),
                            ),
                          ),
                          Column(
                              children: [
                                Text('', style: const TextStyle(fontSize: 10)),
                                Text('', style: const TextStyle(fontSize: 10)),
                                Text('', style: const TextStyle(fontSize: 10)),
                              ]
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 139.58,
                      height: 256.44,
                      margin: const EdgeInsets.only(left: 22.0, top: 18.0),
                      child: Image.asset('assets/images/upload_image_sample.png'),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  }

