import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Post_List_view extends StatefulWidget{
  @override
  Post_List_viewState createState() => Post_List_viewState();
}
class Post{ //게시글에 담긴 정보들
  String? username; //닉네임
  double? scope; //별점
  String? title; //게시글 제목
  String? locate; //위치
  int? price; //보수
  bool? state; //상태 (진행중 or 완료됨)
  int? time; //시간 (n분전)
  Post(this.username, this.scope, this.title,
      this.locate, this.price, this.state, this.time);
  String getState() { //상태에 따라 텍스트 출력
    if(state == null)
        return "";
    else if(state!) //true일 때 진행중
      return "진행중";
    else //false일 때 완료됨
      return "완료됨";
  }
}
class Post_List_viewState extends State<Post_List_view>{
  ScrollController _scrollController = ScrollController();
  int itemCount = 1;
  Color decide_color(bool? state){
    Color state_color;
    if(state == null)
      {
        state_color = Color(0xffCCB9AB);
        return state_color;
      }
    else if(state)
      {
        state_color = Color(0xffAA7651);
        return state_color;
      }
    else
      {
        state_color = Color(0xffCCB9AB);
        return state_color;
      }
  }
  @override
  void initState(){
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent)
      {
        setState(() {
          itemCount++;
        });
      }
    });
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  var priceFormat = NumberFormat('###,###,###,###');
  Post p1 = Post("정다은", 4.8, "스타벅스 유스베리티 따뜻한 거",
      "디자인관 1층", 2000, true, 1);
  Post p2 = Post("정다은", 4.8, "아아 2잔 10분내로 오면+1000",
      "중앙도서관 2층", 2000, false, 4);
  Post p3 = Post("정다은", 4.8, "프린트 ㅃㄹㅃㄹ 제발요",
      "c25-101", 3000, true, 10);
  Post p4 = Post("정다은", 4.8, "충전기 한시간만 빌려주세요",
      "중앙도서관 1층", 1000, false, 15);
  Post p5 = Post("정다은", 4.8, "밥 같이 먹어 줄 사람? 밥사드림",
      "", 0, null, 0);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (context, index){
        return Container( width: 322, height: 581, //게시글 큰틀
            margin: EdgeInsets.only(left: 19),
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
            ),
            child: Column(
              children: [
                //게시물 1
                GestureDetector(
                onTap: () {
                  print('Container1 clicked!');
                },
                child: Container( width: 322, height: 100, //게시글 1개
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                    child: Row( //닉네임, 평점
                      children: [
                        Container( height: 14, //닉네임
                          margin: EdgeInsets.only(left: 15, top: 16),
                          child: Text("${p1.username}", style: TextStyle(
                            fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300, fontSize: 12,
                            letterSpacing: 0.01, color: Color(0xff7E7E7E),
                          ),),
                        ),
                        Container( height:14, //평점
                          margin: EdgeInsets.only(top: 16),
                          child: Text(" ${p1.scope}점", style: TextStyle(
                            fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300, fontSize: 12,
                            letterSpacing: 0.01, color: Color(0xff7E7E7E),
                          ),),
                        )
                      ],
                    )
                ),
                Container( //게시글 제목
                  margin: EdgeInsets.only(top: 8,left: 15,),
                  child: Text("${p1.title}", style: TextStyle(
                    fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600, fontSize: 16,
                    letterSpacing: 0.01, color: Color(0xff111111),
                  ),),
                ),
                Container(
                    child: Row( //위치, 가격
                      children: [
                        Container( margin: EdgeInsets.only(left: 15, top: 10),
                          child: Text("${p1.locate}   ", style: TextStyle(
                            fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500, fontSize: 13,
                            letterSpacing: 0.01, color: Color(0xff000000),
                          ),),),
                        Container( margin: EdgeInsets.only(top: 10),
                          child: Text("\u20A9${priceFormat.format(p1.price)}", style: TextStyle(
                            fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500, fontSize: 13,
                            letterSpacing: 0.01, color: Color(0xffEC5147),
                          ),),),
                        Container(
                          margin: EdgeInsets.only(left: 11.0, top: 8.95),
                          padding: EdgeInsets.all(2),
                          width: 44.36, height: 18.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: decide_color(p1.state),
                          ),
                          child: Center( //상태
                            child: Text(p1.getState(), style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 11,
                                letterSpacing: 0.01, color: Color(0xffFFFFFF)
                            ),),
                          ),
                        ),
                              Expanded(
                                  child: Align(alignment: Alignment.centerRight,
                                child: Container( //시간
                                  margin: EdgeInsets.only(right: 14, top: 17.95),
                                  child: Text("${p1.time}분 전",
                                    style: TextStyle(
                                        fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400, fontSize: 12,
                                        letterSpacing: 0.001, color: Color(0xff434343)),
                                  ),))),
                            ],)),
                ],
            )
        ),),
                //게시글 간에 수평선
                Container(child: Center(child: Container(width: 312, child: Divider(color: Color(0xffDBDBDB), thickness: 0.5)))),
                //게시물 2
                GestureDetector(
                  onTap: () {
                    print('Container2 clicked!');
                  }, //게시물 2
                  child: Container( width: 322, height: 100, //게시글 2번
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                              child: Row( //닉네임, 평점
                                children: [
                                  Container( height: 14, //닉네임
                                    margin: EdgeInsets.only(left: 15, top: 16),
                                    child: Text("${p2.username}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  ),
                                  Container( height:14, //평점
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(" ${p2.scope}점", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  )
                                ],
                              )
                          ),
                          Container( //게시글 제목
                            margin: EdgeInsets.only(top: 8,left: 15,),
                            child: Text("${p2.title}", style: TextStyle(
                              fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600, fontSize: 16,
                              letterSpacing: 0.01, color: Color(0xff111111),
                            ),),
                          ),
                          Container(
                              child: Row( //위치, 가격
                                children: [
                                  Container( margin: EdgeInsets.only(left: 15, top: 10),
                                    child: Text("${p2.locate}   ", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xff000000),
                                    ),),),
                                  Container( margin: EdgeInsets.only(top: 10),
                                    child: Text("\u20A9${priceFormat.format(p2.price)}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xffEC5147),
                                    ),),),
                                  Container(
                                    margin: EdgeInsets.only(left: 11.0, top: 8.95),
                                    padding: EdgeInsets.all(2),
                                    width: 44.36, height: 18.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      color: decide_color(p2.state),
                                    ),
                                    child: Center( //상태
                                      child: Text(p2.getState(), style: TextStyle(
                                          fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500, fontSize: 11,
                                          letterSpacing: 0.01, color: Color(0xffFFFFFF)
                                      ),),
                                    ),
                                  ),
                                  Expanded(
                                      child: Align(alignment: Alignment.centerRight,
                                          child: Container( //시간
                                            margin: EdgeInsets.only(right: 14, top: 17.95),
                                            child: Text("${p2.time}분 전",
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400, fontSize: 12,
                                                  letterSpacing: 0.001, color: Color(0xff434343)),
                                            ),))),
                                ],)),
                        ],
                      )
                  ),
                ),
                //게시글 간에 수평선
                Container(child: Center(child: Container(width: 312, child: Divider(color: Color(0xffDBDBDB), thickness: 0.5)))),
                //게시물 3
                GestureDetector(
                  onTap: () {
                    print('Container3 clicked!');
                  }, //게시물 3
                  child: Container( width: 322, height: 100, //게시글 3번
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                              child: Row( //닉네임, 평점
                                children: [
                                  Container( height: 14, //닉네임
                                    margin: EdgeInsets.only(left: 15, top: 16),
                                    child: Text("${p3.username}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  ),
                                  Container( height:14, //평점
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(" ${p3.scope}점", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  )
                                ],
                              )
                          ),
                          Container( //게시글 제목
                            margin: EdgeInsets.only(top: 8,left: 15,),
                            child: Text("${p3.title}", style: TextStyle(
                              fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600, fontSize: 16,
                              letterSpacing: 0.01, color: Color(0xff111111),
                            ),),
                          ),
                          Container(
                              child: Row( //위치, 가격
                                children: [
                                  Container( margin: EdgeInsets.only(left: 15, top: 10),
                                    child: Text("${p3.locate}   ", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xff000000),
                                    ),),),
                                  Container( margin: EdgeInsets.only(top: 10),
                                    child: Text("\u20A9${priceFormat.format(p3.price)}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xffEC5147),
                                    ),),),
                                  Container(
                                    margin: EdgeInsets.only(left: 11.0, top: 8.95),
                                    padding: EdgeInsets.all(2),
                                    width: 44.36, height: 18.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      color: decide_color(p3.state),
                                    ),
                                    child: Center( //상태
                                      child: Text(p3.getState(), style: TextStyle(
                                          fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500, fontSize: 11,
                                          letterSpacing: 0.01, color: Color(0xffFFFFFF)
                                      ),),
                                    ),
                                  ),
                                  Expanded(
                                      child: Align(alignment: Alignment.centerRight,
                                          child: Container( //시간
                                            margin: EdgeInsets.only(right: 14, top: 17.95),
                                            child: Text("${p3.time}분 전",
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400, fontSize: 12,
                                                  letterSpacing: 0.001, color: Color(0xff434343)),
                                            ),))),
                                ],)),
                        ],
                      )
                  ),
                ),
                //게시글 간에 수평선
                Container(child: Center(child: Container(width: 312, child: Divider(color: Color(0xffDBDBDB), thickness: 0.5)))),
                //게시물 4
                GestureDetector(
                  onTap: () {
                    print('Container4 clicked!');
                  }, //게시물 4
                  child: Container( width: 322, height: 100, //게시글 4번
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                              child: Row( //닉네임, 평점
                                children: [
                                  Container( height: 14, //닉네임
                                    margin: EdgeInsets.only(left: 15, top: 16),
                                    child: Text("${p4.username}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  ),
                                  Container( height:14, //평점
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(" ${p4.scope}점", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  )
                                ],
                              )
                          ),
                          Container( //게시글 제목
                            margin: EdgeInsets.only(top: 8,left: 15,),
                            child: Text("${p4.title}", style: TextStyle(
                              fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600, fontSize: 16,
                              letterSpacing: 0.01, color: Color(0xff111111),
                            ),),
                          ),
                          Container(
                              child: Row( //위치, 가격
                                children: [
                                  Container( margin: EdgeInsets.only(left: 15, top: 10),
                                    child: Text("${p4.locate}   ", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xff000000),
                                    ),),),
                                  Container( margin: EdgeInsets.only(top: 10),
                                    child: Text("\u20A9${priceFormat.format(p4.price)}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xffEC5147),
                                    ),),),
                                  Container(
                                    margin: EdgeInsets.only(left: 11.0, top: 8.95),
                                    padding: EdgeInsets.all(2),
                                    width: 44.36, height: 18.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      color: decide_color(p4.state),
                                    ),
                                    child: Center( //상태
                                      child: Text(p4.getState(), style: TextStyle(
                                          fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500, fontSize: 11,
                                          letterSpacing: 0.01, color: Color(0xffFFFFFF)
                                      ),),
                                    ),
                                  ),
                                  Expanded(
                                      child: Align(alignment: Alignment.centerRight,
                                          child: Container( //시간
                                            margin: EdgeInsets.only(right: 14, top: 17.95),
                                            child: Text("${p4.time}분 전",
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400, fontSize: 12,
                                                  letterSpacing: 0.001, color: Color(0xff434343)),
                                            ),))),
                                ],)),
                        ],
                      )
                  ),
                ),
                //게시글 간에 수평선
                Container(child: Center(child: Container(width: 312, child: Divider(color: Color(0xffDBDBDB), thickness: 0.5)))),
                //게시물 5
                GestureDetector(
                  onTap: () {
                    print('Container5 clicked!');
                  }, //게시물 5
                  child: Container( width: 322, height: 100, //게시글 5번
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                              child: Row( //닉네임, 평점
                                children: [
                                  Container( height: 14, //닉네임
                                    margin: EdgeInsets.only(left: 15, top: 16),
                                    child: Text("${p5.username}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  ),
                                  Container( height:14, //평점
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(" ${p5.scope}점", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300, fontSize: 12,
                                      letterSpacing: 0.01, color: Color(0xff7E7E7E),
                                    ),),
                                  )
                                ],
                              )
                          ),
                          Container( //게시글 제목
                            margin: EdgeInsets.only(top: 8,left: 15,),
                            child: Text("${p5.title}", style: TextStyle(
                              fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600, fontSize: 16,
                              letterSpacing: 0.01, color: Color(0xff111111),
                            ),),
                          ),
                          Container(
                              child: Row( //위치, 가격
                                children: [
                                  Container( margin: EdgeInsets.only(left: 15, top: 10),
                                    child: Text("${p5.locate}   ", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xff000000),
                                    ),),),
                                  Container( margin: EdgeInsets.only(top: 10),
                                    child: Text("\u20A9${priceFormat.format(p5.price)}", style: TextStyle(
                                      fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500, fontSize: 13,
                                      letterSpacing: 0.01, color: Color(0xffEC5147),
                                    ),),),
                                  Container(
                                    margin: EdgeInsets.only(left: 11.0, top: 8.95),
                                    padding: EdgeInsets.all(2),
                                    width: 44.36, height: 18.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      color: decide_color(p5.state),
                                    ),
                                    child: Center( //상태
                                      child: Text(p5.getState(), style: TextStyle(
                                          fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500, fontSize: 11,
                                          letterSpacing: 0.01, color: Color(0xffFFFFFF)
                                      ),),
                                    ),
                                  ),
                                  Expanded(
                                      child: Align(alignment: Alignment.centerRight,
                                          child: Container( //시간
                                            margin: EdgeInsets.only(right: 14, top: 17.95),
                                            child: Text("${p1.time}분 전",
                                              style: TextStyle(
                                                  fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400, fontSize: 12,
                                                  letterSpacing: 0.001, color: Color(0xff434343)),
                                            ),))),
                                ],)),
                        ],
                      )
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Container(
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height:16.36),
                Flexible(
                  child: Post_List_view(),
                ),

              ],
            ),
          ),
          Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container( width: 364, height: 64,
                     decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                          border: Border.all(
                          color: Color(0xffCFCFCF),
                          width: 0.5,),
                     boxShadow: [
                     BoxShadow(
                     color: Color.fromRGBO(185, 185, 185, 0.25),
                     offset: Offset(5, -1),blurRadius: 5, spreadRadius: 1,),],),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 22, height: 22,
                          margin : const EdgeInsets.only(left: 44, top: 20.0, bottom: 17.32),
                          child: IconButton(
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                      onPressed: () {
                      },
                      icon: Image.asset('assets/images/home_icon.png',
                        color: Color(0xff545454),
                      ),
                    ),),
                  Container(width: 19.31, height: 23.81,
                    margin : const EdgeInsets.only(top: 20.0, bottom: 17.32),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                      },
                      icon: Image.asset('assets/images/human_icon.png',
                        color: Color(0xffADADAD),
                      ),
                    ),),
                  Container(width: 22.0, height: 22,
                    margin : const EdgeInsets.only(top: 20.0, bottom: 17.32),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                      },
                      icon: Image.asset('assets/images/add_icon.png',
                        color: Color(0xffADADAD),
                      ),
                    ),),
                  Container(width: 21.95, height: 24.21,
                    margin : const EdgeInsets.only(top: 20.0,bottom: 17.32, right: 43.92),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                      },
                      icon: Image.asset('assets/images/history_icon.png',
                        color: Color(0xffADADAD),
                      ),
                    ),),

                ]
              )))
        ],)
        ),
    );
  }
  }

