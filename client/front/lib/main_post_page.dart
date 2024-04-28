import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Main_post_page extends StatefulWidget {
  const Main_post_page({Key? key}) : super(key: key);
  @override
  _Main_post_pageState createState() => _Main_post_pageState();
}
class _Main_post_pageState extends State<Main_post_page> {
  bool button1state = true; //초기 설정 값
  bool button2state = false;
  bool button3state = false;
  bool isCheckBox = false;
  Color button1_text_color = Color(0xff7C2E1A); //초기 색상 값
  Color button1_border_color = Color(0xff7C3D1A);
  Color button2_text_color = Color(0xff4A4A4A);
  Color button2_border_color = Color(0xffB1B1B1);
  Color button3_text_color = Color(0xff4A4A4A);
  Color button3_border_color = Color(0xffB1B1B1);
  Color checkbox_text_color = Color(0xff606060);

  void change_Button_State(){ //색 변경
    setState(() {
      if(button1state)
      {button1_text_color = Color(0xff7C2E1A);
        button1_border_color = Color(0xff7C3D1A);}
      else
        {button1_text_color = Color(0xff4A4A4A);
          button1_border_color = Color(0xffB1B1B1);}

      if(button2state)
      {button2_text_color = Color(0xff7C2E1A);
        button2_border_color = Color(0xff7C3D1A);}
      else
      {button2_text_color = Color(0xff4A4A4A);
        button2_border_color = Color(0xffB1B1B1);}

      if(button3state)
      {button3_text_color = Color(0xff7C2E1A);
      button3_border_color = Color(0xff7C3D1A);}
      else
      {button3_text_color = Color(0xff4A4A4A);
      button3_border_color = Color(0xffB1B1B1);}
    });
  }
  void change_checkbox_state()
  {
    setState(() {
      if(isCheckBox)
       checkbox_text_color = Color(0xff292929);
      else
        checkbox_text_color = Color(0xff606060);
    });
  }



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
                    SizedBox(width: 194),
                    Container(width: 23.0, height: 21.91,
                      margin : const EdgeInsets.only(top: 35.0,right: 14),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed:
                            () {},
                        icon: Image.asset('assets/images/search_icon.png',
                        ),
                      ),
                    ),
                    Container(width: 23.0, height: 21.91,
                      margin : const EdgeInsets.only(top: 34.0,right: 21.31),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
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
                    GestureDetector( //버튼1
                      onTap: () {
                        button1state = true;
                        button2state = false;
                        button3state = false;
                        change_Button_State();
                      },
                      child: Container(width: 70, height: 32,
                        margin: const EdgeInsets.only(left: 27, top: 19.0),
                        child: Stack(
                          children: [
                            Positioned(left: 0, top: 0,
                              child: Container(width: 70, height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  border: Border.all(color: button1_border_color, width: 1,),
                                  borderRadius: BorderRadius.circular(10),
                                ),),), // Text
                            Positioned(left: 16.72, top: 7.72,
                              child: Text('최신순', style: TextStyle(
                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500, fontSize: 14,
                                  letterSpacing: 0.001, color: button1_text_color,
                                ),),),
                          ],),),),
                    GestureDetector( //버튼2
                      onTap: () {
                        button1state = false;
                        button2state = true;
                        button3state = false;
                        change_Button_State();
                      },
                      child: Container(width: 70, height: 32,
                        margin: const EdgeInsets.only(left: 11, top: 19.0),
                        child: Stack(
                          children: [
                            Positioned(left: 0, top: 0,
                              child: Container(width: 70, height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  border: Border.all(color: button2_border_color, width: 1,),
                                  borderRadius: BorderRadius.circular(10),
                                ),),), // Text
                            Positioned(left: 16.72, top: 7.72,
                              child: Text('금액순', style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 14,
                                letterSpacing: 0.001, color: button2_text_color,
                              ),),),
                          ],),),),
                    GestureDetector( //버튼3
                      onTap: () {
                        button1state = false;
                        button2state = false;
                        button3state = true;
                        change_Button_State();
                      },
                      child: Container(width: 70, height: 32,
                        margin: const EdgeInsets.only(left: 11, top: 19.0),
                        child: Stack(
                          children: [
                            Positioned(left: 0, top: 0,
                              child: Container(width: 70, height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  border: Border.all(color: button3_border_color, width: 1,),
                                  borderRadius: BorderRadius.circular(10),
                                ),),), // Text
                            Positioned(left: 16.72, top: 7.72,
                              child: Text('거리순', style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 14,
                                letterSpacing: 0.001, color: button3_text_color,
                              ),),),
                          ],),),)
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container( width: 20, height: 20,
                      margin: EdgeInsets.only(left: 27, top: 16.36),
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(width: 1.0, color: Color(0xffC5C5C5)),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: Color(0xffA97651),
                        value: isCheckBox,
                        onChanged: (value) {
                          setState(() {
                            isCheckBox = value!;
                            change_checkbox_state();
                          });
                        },
                      ),
                    ),
                    Container( height: 17,
                      margin: EdgeInsets.only(left: 2.28, top: 14.86),
                      child: Text('진행 중 모아보기', style: TextStyle(
                        fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500, fontSize: 14,
                        letterSpacing: 0.001, color: checkbox_text_color,
                      ),),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  }

