import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'upload_image.dart';
import 'package:front/upload_image.dart';
import 'profile.dart';
// class Student {
//   String studentID;
//   String major;
//   String name;
//   Student(this.studentID, this.major, this.name);
// }
// final Student s1;

//   final String studentID;
//   final String major;
//   final String name;
//
//   const Check_Image(this.studentID, this.major, this.name)

class Check_Image extends StatelessWidget {
  final Student s1;
  Check_Image( {Key? key, required this.s1, }): super (key: key);

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
                      fontFamily: 'paybooc',fontSize: 20, fontWeight: FontWeight.bold,
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
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                  width: 320, height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xffF0F0F0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 12.0),
                    child: Text(s1.major, style: TextStyle(
                      fontSize: 13, fontFamily: 'Pretendard',
                      letterSpacing: 0.01, color: Color(0xff404040),
                    ),),
                  ),
                ),
                  Container(
                      margin: EdgeInsets.only(left: 22.0, top: 28.0),
                      child: Text('학번', style: TextStyle(
                        fontFamily: 'Pretendard',fontSize: 14, fontWeight: FontWeight.bold,
                        letterSpacing: 0.01, color: Color(0xff373737),))),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                  width: 320, height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xffF0F0F0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 12.0),
                    child: Text(s1.studentID, style: TextStyle(
                        fontSize: 13, fontFamily: 'Pretendard',
                        letterSpacing: 0.01, color: Color(0xff404040),
                      ),),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 22.0, top: 28.0),
                    child: Text('이름', style: TextStyle(
                      fontFamily: 'Pretendard',fontSize: 14, fontWeight: FontWeight.bold,
                      letterSpacing: 0.01, color: Color(0xff373737),))),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                  width: 320, height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xffF0F0F0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 12.0),
                    child: Text(s1.name, style: TextStyle(
                      fontSize: 13, fontFamily: 'Pretendard',
                      letterSpacing: 0.01, color: Color(0xff404040),
                    ),),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 21.0, top: 33.0),
                    child: Text('해당 정보가 일치하다면 확인 버튼을 눌러주세요.', style: TextStyle(
                      fontFamily: 'Pretendard',fontSize: 13, fontWeight: FontWeight.w500,
                      letterSpacing: 0.01, color: Color(0xff343434),))),
                Container(margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 9.0),
                  width: 320,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff7C3D1A),
                      border: Border.all(
                        width: 0.5,
                        color: Color(0xffACACAC),
                      ),
                      borderRadius: BorderRadius.circular(10.0),

                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => ProfileScreen(),
                            ),);
                      },
                    child: Text('확인', style: TextStyle(fontSize: 16,
                      fontFamily: 'Pretendard', letterSpacing: 0.01,color: Color(0xffFFFFFF),
                    ),),),
                      //keyboardType: TextInputType.text, api로 입력받는 기능 추가해야함
                  ),),
                Container(
                    margin: EdgeInsets.only(left: 20.0, top: 12.0),
                    child: Text('* 해당 정보가 일치하지 않으면 이전 페이지로 돌아가 재촬영 하세요.', style: TextStyle(
                      fontFamily: 'Pretendard',fontSize: 12, fontWeight: FontWeight.w400,
                      letterSpacing: 0.01, color: Color(0xffFF4B4B),))),
              ],
                    )
                )
            ),
          );
  }}