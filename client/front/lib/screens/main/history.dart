import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/widgets/bar/navigation_bar.dart';

import 'utils/set_button_colors.dart';
final storage = FlutterSecureStorage();


class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  @override
  State createState() => HistoryState();
}
class HistoryState extends State<History> {
  bool button1state = true; //초기 설정 값
  bool button2state = false;
  Color button1TextColor = const Color(0xff7C2E1A); //초기 색상 값
  Color button1BorderColor =const Color(0xff7C3D1A);
  Color button2TextColor = const Color(0xff4A4A4A);
  Color button2BorderColor = const Color(0xffB1B1B1);
  void updateButtonState() {
    setState(() {
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
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      insertOverlay(context);
    });
    //ErrandLatestInit(); //최신순 요청서 12개
    //InprogressExist(); //진행중인 심부름이 있는지 확인
    //InProgressErrandInit(); //진행중인 심부름 목록 불러오기
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
           icon: Icon(Icons.arrow_back_ios),
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
                 color: Color(0xFF111111),
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
            GestureDetector( //버튼1
              onTap: () {
                button1state = true;
                button2state = false;
              },
              child: Container(width: 70.w, height: 32.h,
                margin: EdgeInsets.only(left: 27.w, top: 19.h, ),
                child: Stack(
                  children: [
                    Positioned(left: 0.w, top: 0.h,
                      child: Container(width: 70.w, height: 32.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFFBFBFB),
                          border: Border.all(
                            color: button1BorderColor, width: 1.w,),
                          borderRadius: BorderRadius.circular(10),
                        ),),), // Text
                    Positioned(left: 16.72.w, top: 7.72.h,
                      child: Text('최신순', style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: 0.001,
                        color: button1TextColor,
                      ),),),
                  ],),),),
          ],
        ),
      ],
    ),
   );
  }
}