import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/screens/main/history_client.dart';
import 'package:front/screens/main/history_runner.dart';
import 'package:front/widgets/bar/navigation_bar.dart';
import 'utils/set_button_colors.dart';
import 'widgets/button/filter_button.dart';
import 'widgets/history_widget.dart';
import 'widgets/class/history_class.dart';
const storage = FlutterSecureStorage();

class History extends StatefulWidget {
  const History({super.key});
  @override
  State createState() => HistoryState();
}
class HistoryState extends State<History> {
  List<Map<String, dynamic>> historys = [];
  String? token = "";
  historyRequestInit() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/myErrand/order";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        HistoryData h1 = HistoryData.fromJson(item);
        historys.add({
          "orderNo": h1.o1.orderNo,
          "nickname": h1.o1.nickname,
          "score": h1.o1.score,
          "errandNo": h1.errandNo,
          "createdDate": h1.createdDate,
          "title": h1.title,
          "destination": h1.destination,
          "reward": h1.reward,
          "status": h1.status,
        });
        if (kDebugMode) {
          print('errand latest init 200');
        }
      }
      setState(() {});
    }
    else{
      if (kDebugMode) {
        print("error");
      }
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        if (kDebugMode) {
          print(error.httpStatus);
          print(error.message);
        }
      }
      else if(error.code == "INVALID_VALUE")
      {
        if (kDebugMode) {
          print(error.httpStatus);
          print(error.message);
        }
      }
      else
      {
        if (kDebugMode) {
          print(error.code);
          print(error.httpStatus);
          print(error.message);
        }
      }
    }
  }
  historyDoErrandInit() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/myErrand/errander";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        HistoryData h1 = HistoryData.fromJson(item);
        historys.add({
          "orderNo": h1.o1.orderNo,
          "nickname": h1.o1.nickname,
          "score": h1.o1.score,
          "errandNo": h1.errandNo,
          "createdDate": h1.createdDate,
          "title": h1.title,
          "destination": h1.destination,
          "reward": h1.reward,
          "status": h1.status,
        });
        if (kDebugMode) {
          print('errand latest init 200');
        }
      }
      setState(() {});
    }
    else{
      if (kDebugMode) {
        print("error");
      }
      Map<String, dynamic> json = jsonDecode(response.body);
      Error error = Error.fromJson(json);
      if(error.code == "INVALID_FORMAT") {
        if (kDebugMode) {
          print(error.httpStatus);
          print(error.message);
        }
      }
      else if(error.code == "INVALID_VALUE")
      {
        if (kDebugMode) {
          print(error.httpStatus);
          print(error.message);
        }
      }
      else
      {
        if (kDebugMode) {
          print(error.code);
          print(error.httpStatus);
          print(error.message);
        }
      }
    }
  }


  bool button1state = true; //초기 설정 값
  bool button2state = false;
  Color button1TextColor = const Color(0xff7C2E1A); //초기 색상 값
  Color button1BorderColor =const Color(0xff7C3D1A);
  Color button2TextColor = const Color(0xff4A4A4A);
  Color button2BorderColor = const Color(0xffB1B1B1);
  void updateButtonState() { //버튼 상태와 현재 색을 입력 하면
    setState(() { //변경된 색으로 상태를 update 해줌
      changeButtonState(
        button1state: button1state,
        button2state: button2state,
        setButton1TextColor: (color) => button1TextColor = color,
        setButton1BorderColor: (color) => button1BorderColor = color,
        setButton2TextColor: (color) => button2TextColor = color,
        setButton2BorderColor: (color) => button2BorderColor = color,
      );
    });
  }
  final ScrollController _scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      insertOverlay(context);
    });
    setState(() {
      historyDoErrandInit();
    });
    //ErrandLatestInit(); //최신순 요청서 12개
    //InprogressExist(); //진행 중인 심부름이 있는지 확인
    //InProgressErrandInit(); //진행 중인 심부름 목록 불러오기
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w, top: 31.h),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              height: 25.0.h,
              margin: EdgeInsets.only(left: 90.w, top:27.h),
              child: Text(
                '히스토리',
                style: TextStyle(
                    color: const Color(0xFF111111),
                    fontFamily: 'Paybooc',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    letterSpacing: 0.01
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 22.w,),
            GestureDetector( //버튼1
              onTap: () {
                button1state = true;
                button2state = false;
                updateButtonState();
                historys.clear();
                historyDoErrandInit();
              },
              child: filterButton2(
                button1BorderColor,
                button1TextColor,
                '수행한 심부름'
              ),
            ),
            GestureDetector( //버튼2
              onTap: () {
                button1state = false;
                button2state = true;
                updateButtonState();
                historys.clear();
                historyRequestInit();
              },
              child: filterButton2(
                  button2BorderColor,
                  button2TextColor,
                  '요청한 심부름'
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Flexible(
          child: Container(width: 360.w, height: 700.h,
            //게시글 큰틀
            child: ListView.builder(
                padding: EdgeInsets.only(top: 0.1.h, bottom: 55.h,),
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: historys.length,
                itemBuilder: (BuildContext context, int index) {
                  String nickname = historys[index]["nickname"];
                  String title = historys[index]['title'];
                  String createdDate = historys[index]["createdDate"];
                  String destination = historys[index]["destination"];
                  String decodedNickname = utf8.decode(
                      nickname.runes.toList());
                  String decodedTitle = utf8.decode(
                      title.runes.toList());
                  String decodedCreatedDate = utf8.decode(
                      createdDate.runes.toList());
                  String decodedDestination = utf8.decode(
                      destination.runes.toList());
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    //게시글 전체를 클릭영역으로 만들어주는 코드
                    onTap: () {
                      if (button1state) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HistoryDoerrand(
                              errandNo: historys[index]["errandNo"],
                            ),
                          ),
                        );
                      }
                      if (button2state) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HistoryRequest(
                              errandNo: historys[index]["errandNo"],
                            ),
                          ),
                        );
                      }
                    },
                    child: HistoryWidget(
                      orderNo: historys[index]["orderNo"],
                      nickname: decodedNickname,
                      score: historys[index]["score"],
                      errandNo: historys[index]["errandNo"],
                      errandDate: decodedCreatedDate,
                      title: decodedTitle,
                      destination: decodedDestination,
                      reward: historys[index]["reward"],
                      status: historys[index]["status"],
                    ),
                  );
                }
            ),
          ),
        ),
      ],
    ),
   );
  }
}