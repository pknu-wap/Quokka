import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'request.dart';
final List<Map<String, dynamic>> latestposts = [];
final List<Map<String, dynamic>> rewardposts = [];
bool button1state = true; //초기 설정 값
bool button2state = false;
bool button3state = false;

class PostWidget extends StatelessWidget {
  final int orderNo; //요청자 번호
  final String nickname; //닉네임
  final double score; //평점
  final int errandNo; //게시글 번호
  final String createdDate; //생성시간
  final String title; //제목
  final String destination; //목적지
  final int reward; //보수
  final String status; //상태 (모집중, 진행중, 완료됨)
  const PostWidget({
    Key? key,
    required this.orderNo,
    required this.nickname,
    required this.score,
    required this.errandNo,
    required this.createdDate,
    required this.title,
    required this.destination,
    required this.reward,
    required this.status,
  }) : super(key: key);

  String getState() { //상태에 따라 텍스트 출력
    if(status == "RECRUITING")
      {
        return "모집중";
      }
    else if(status == "IN_PROGRESS")
      return "진행중";
    else if(status == "DONE")
      return "완료됨";
    else
      {
        return "";
      }
  }
  Color decide_color(String state){
    Color state_color;
    if(state == "RECRUITING")
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
  Widget build(BuildContext context) {
    var priceFormat = NumberFormat('###,###,###,###');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                              child: Text("${nickname}", style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300, fontSize: 12,
                                letterSpacing: 0.01, color: Color(0xff7E7E7E),
                              ),),
                            ),
                            Container( height:14, //평점
                              margin: EdgeInsets.only(top: 16),
                              child: Text(" ${score}점", style: TextStyle(
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
                      child: Text("${title}", style: TextStyle(
                        fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600, fontSize: 16,
                        letterSpacing: 0.01, color: Color(0xff111111),
                      ),),
                    ),
                    Container(
                        child: Row( //위치, 가격
                          children: [
                            Container( margin: EdgeInsets.only(left: 15, top: 10),
                              child: Text("${destination}   ", style: TextStyle(
                                fontFamily: 'Pretendard', fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500, fontSize: 13,
                                letterSpacing: 0.01, color: Color(0xff000000),
                              ),),),
                            Container( margin: EdgeInsets.only(top: 10),
                              child: Text("\u20A9${priceFormat.format(reward)}", style: TextStyle(
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
                                color: decide_color(status),
                              ),
                              child: Center( //상태
                                child: Text(getState(), style: TextStyle(
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
                                      child: Text("${createdDate}",
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
          Container(child: Center(child: Container(width: 312, child: Divider(color: Color(0xffDBDBDB), thickness: 0.5)))),
        ],
      ),

    );


  }
}
class order{
  int orderNo;
  String nickname; //닉네임
  double score; //평점
  order(this.orderNo, this.nickname, this.score);
  factory order.fromJson(Map<String, dynamic> json) {
    return order(
      json['orderNo'],
      json['nickname'],
      json['score'],
    );
  }
}
class Post{//게시글에 담긴 정보들
  order o1;
  int errandNo; //게시글 번호
  String createdDate; //생성된 날짜
  String title; //게시글 제목
  String destination; //위치
  int reward; //보수
  String status; //상태 (모집중 or 진행중 or 완료됨)
  Post(this.o1, this.errandNo, this.createdDate, this.title,
      this.destination, this.reward, this.status);
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      order.fromJson(json['order']),
      json['errandNo'],
      json['createdDate'],
      json['title'],
      json['destination'],
      json['reward'],
      json['status'],
    );
  }
}
class Error{
  String code;
  var httpStatus;
  String message;
  Error(this.code,this.httpStatus,this.message);
  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      json['code'],
      json['httpStatus'],
      json['message'],
    );
  }
}

class Main_post_page extends StatefulWidget {
  const Main_post_page({Key? key}) : super(key: key);
  @override
  _Main_post_pageState createState() => _Main_post_pageState();
}
class _Main_post_pageState extends State<Main_post_page> {
  ErrandLatestInit() async{
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/errand/"
        "latest?pk=-1&cursor=3000-01-01 00:00:00.000000&limit=5&status=";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InN0cmluZyIsInJvbGUiOiJST0xFX0FETUlOIiwiaWF0IjoxNzE1NDIxNTY5LCJleHAiOjE3MTU3ODE1Njl9.4MKt_VafJW6ZzniWQRlOBxKKDOyujvmsZvxI5sYiG7M"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        latestposts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandRewardInit() async{
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/errand/"
        "reward?pk=-1&cursor=1000000&limit=5&status=";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InN0cmluZyIsInJvbGUiOiJST0xFX0FETUlOIiwiaWF0IjoxNzE1NDIxNTY5LCJleHAiOjE3MTU3ODE1Njl9.4MKt_VafJW6ZzniWQRlOBxKKDOyujvmsZvxI5sYiG7M"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        rewardposts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandLatestAdd() async{
    Map<String, dynamic> lastPost = latestposts.last;
    int lasterrandNo = lastPost['errandNo'];
    String lastcreatedDate = lastPost['createdDate'];
    String lastCreatedDate = utf8.decode(lastcreatedDate.runes.toList());
    print(lasterrandNo);
    print(lastCreatedDate);
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/errand/"
        "latest?pk=$lasterrandNo&cursor=$lastCreatedDate&limit=5&status=";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InN0cmluZyIsInJvbGUiOiJST0xFX0FETUlOIiwiaWF0IjoxNzE1NDIxNTY5LCJleHAiOjE3MTU3ODE1Njl9.4MKt_VafJW6ZzniWQRlOBxKKDOyujvmsZvxI5sYiG7M"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        latestposts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
        print(lasterrandNo);
        print(lastCreatedDate);
      }
      setState(() {
      });
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ErrandRewardAdd() async{
    Map<String, dynamic> lastPost = rewardposts.last;
    int lasterrandNo = lastPost['errandNo'];
    int lastreward = lastPost['reward'];
    print(lasterrandNo);
    print(lastreward);
    String url = "http://ec2-43-201-110-178.ap-northeast-2.compute.amazonaws.com:8080/errand/"
        "reward?pk=$lasterrandNo&cursor=$lastreward&limit=5&status=";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InN0cmluZyIsInJvbGUiOiJST0xFX0FETUlOIiwiaWF0IjoxNzE1NDIxNTY5LCJleHAiOjE3MTU3ODE1Njl9.4MKt_VafJW6ZzniWQRlOBxKKDOyujvmsZvxI5sYiG7M"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        rewardposts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        print('200');
      }
      setState(() {});
    }
    else{
      print("error");
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        print(error.httpStatus);
        print(error.message);
      }
      else if(error.code == "INVALID_VALUE")
      {
        print(error.httpStatus);
        print(error.message);
      }
      else
      {
        print(error.code);
        print(error.httpStatus);
        print(error.message);
      }
    }
  }
  ScrollController _scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
    ErrandLatestInit(); //최신순 요청서 5개
    ErrandRewardInit(); //금액순 요청서 5개를 미리 가지고옴
    _scrollController.addListener((){
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) //스크롤을 끝까지 내리면
          {
        setState(() {
          ErrandLatestAdd(); //최신순 요청서 5개
          ErrandRewardAdd(); //금액순 요청서 5개를 추가로 들고옴
        });
      }
    });
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  @override
  void scrollToTop() {
    _scrollController.animateTo( // 애니메이션과 함께 맨 위로 스크롤
      0,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }
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
                          scrollToTop();
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
                          scrollToTop();
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
                          scrollToTop();
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
                  child: Container( width: 322, height: 581, //게시글 큰틀
                    margin: EdgeInsets.only(left: 19),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                    ),
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: latestposts.length,
                      itemBuilder: (BuildContext context, int index){
                        String Lnickname = latestposts[index]["nickname"];
                        String Ltitle = latestposts[index]['title'];
                        String Ldestination = latestposts[index]['destination'];
                        String LcreatedDate = latestposts[index]["createdDate"];
                        String LdecodedNickname = utf8.decode(Lnickname.runes.toList());
                        String LdecodedTitle = utf8.decode(Ltitle.runes.toList());
                        String LdecodedDestination = utf8.decode(Ldestination.runes.toList());
                        String LdecodedCreatedDate = utf8.decode(LcreatedDate.runes.toList());

                        String Rnickname = rewardposts[index]["nickname"];
                        String Rtitle = rewardposts[index]['title'];
                        String Rdestination = rewardposts[index]['destination'];
                        String RcreatedDate = rewardposts[index]["createdDate"];
                        String RdecodedNickname = utf8.decode(Rnickname.runes.toList());
                        String RdecodedTitle = utf8.decode(Rtitle.runes.toList());
                        String RdecodedDestination = utf8.decode(Rdestination.runes.toList());
                        String RdecodedCreatedDate = utf8.decode(RcreatedDate.runes.toList());
                        if(button1state) //버튼 상태에 따라 최신순을 보여줌
                            {
                          return PostWidget(
                            orderNo: latestposts[index]["orderNo"],
                            nickname: LdecodedNickname,
                            score: latestposts[index]["score"],
                            errandNo: latestposts[index]["errandNo"],
                            createdDate: LdecodedCreatedDate,
                            title: LdecodedTitle,
                            destination: LdecodedDestination,
                            reward: latestposts[index]["reward"],
                            status: latestposts[index]["status"],
                          );
                        }
                        else if(button2state) //버튼 상태에 따라 금액순을 보여줌
                            {
                          return PostWidget(
                            orderNo: rewardposts[index]["orderNo"],
                            nickname: RdecodedNickname,
                            score: rewardposts[index]["score"],
                            errandNo: rewardposts[index]["errandNo"],
                            createdDate: RdecodedCreatedDate,
                            title: RdecodedTitle,
                            destination: RdecodedDestination,
                            reward: rewardposts[index]["reward"],
                            status: rewardposts[index]["status"],
                          );
                        }
                      },),
                  ),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Request(),
                          ),
                        );

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

