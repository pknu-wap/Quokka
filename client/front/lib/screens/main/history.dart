import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/widgets/bar/navigation_bar.dart';
import 'utils/set_button_colors.dart';
import 'widgets/button/filter_button.dart';
import 'widgets/history_widget.dart';
const storage = FlutterSecureStorage();

class History extends StatefulWidget {
  const History({super.key});
  @override
  State createState() => HistoryState();
}
class HistoryState extends State<History> {
  List<Map<String, dynamic>> historys = [];
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
    //ErrandLatestInit(); //최신순 요청서 12개
    //InprogressExist(); //진행 중인 심부름이 있는지 확인
    //InProgressErrandInit(); //진행 중인 심부름 목록 불러오기
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       elevation: 0.0,
       leading: Padding(
         padding: EdgeInsets.only(top: 26.0.h),
         child: IconButton(
           icon: const Icon(Icons.arrow_back_ios),
           onPressed: () {
             Navigator.of(context).pop();
           },
         ),
       ),
       title: Padding(
         padding: EdgeInsets.only(top: 26.0.h),
         child: SizedBox(
           height: 25.0.h,
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
       ),
     ),
    body: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 22.w,),
            GestureDetector( //버튼1
              onTap: () {
                button1state = true;
                button2state = false;
                updateButtonState();
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
              },
              child: filterButton2(
                  button2BorderColor,
                  button2TextColor,
                  '요청한 심부름'
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(width: 360.w, height: 581.h,
            //게시글 큰틀
            margin: EdgeInsets.only(left: 19.w,),
            child: ListView.builder(
                padding: EdgeInsets.only(top: 0.1.h, bottom: 45.h,),
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: historys.length,
                itemBuilder: (BuildContext context, int index) {
                  String nickname = historys[index]["nickname"];
                  String title = historys[index]['title'];
                  String destination = historys[index]['destination'];
                  String createdDate = historys[index]["createdDate"];
                  String decodedNickname = utf8.decode(
                      nickname.runes.toList());
                  String decodedTitle = utf8.decode(
                      title.runes.toList());
                  String decodedDestination = utf8.decode(
                      destination.runes.toList());
                  String decodedCreatedDate = utf8.decode(
                      createdDate.runes.toList());
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    //게시글 전체를 클릭영역으로 만들어주는 코드
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           MainErrandCheck(
                      //               errandNo: posts[index]["errandNo"])
                      //   ),);
                    },
                    child: HistoryWidget(
                      orderNo: historys[index]["orderNo"],
                      nickname: decodedNickname,
                      score: historys[index]["score"],
                      errandNo: historys[index]["errandNo"],
                      createdDate: decodedCreatedDate,
                      title: decodedTitle,
                      reward: historys[index]["reward"],
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