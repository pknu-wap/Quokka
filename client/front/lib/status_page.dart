import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class statuspage extends StatefulWidget {
  final int errandNo;
  const statuspage({
    Key? key,
    required this.errandNo,
  }) : super(key: key);

  @override
  State<statuspage> createState() => _statuspageState();
}

class _statuspageState extends State<statuspage> {
  late int errandNo;
  void initState()
  {
    super.initState();
    errandNo = widget.errandNo;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 86, left: 26),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Image.asset(
                            'assets/images/arrow back.png',
                            color: Color(0xff6B6B6B),
                          ),
                        ),
                      ),
                      Container( height: 25,
                        margin: EdgeInsets.only(top: 80, left: 4),
                        child: Text(
                          '현황 페이지',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'paybooc',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ),
                      Container(
                        width: 19.02,
                        height: 26.15,
                        margin: EdgeInsets.only(top: 73.65, left: 139.98),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/map.png',
                            color: Color(0xffB4B5BE),
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 25.81,
                        margin: EdgeInsets.only(top: 74, left: 13),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/errand.png',
                            color: Color(0xffB4B5BE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 355, height: 471.79,
                  margin: EdgeInsets.only(left: 3.45, top: 20.13),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    //color: Colors.blue,
                    border: Border.all(color: Colors.transparent, width: 1,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(top: 24.08, left: 21),
            child: ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 실행될 코드
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffB99988), // 배경색
                fixedSize: Size(318, 45), // 너비와 높이
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 테두리 둥글기 설정 (0은 둥글지 않음)
                ),
              ),
              child: Container( width: 318, height: 45,
                alignment: Alignment.center,
                child: Text(
                  '심부름 완료',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.01,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
          ),
              ],
            ),
          ),
        ),
    );
  }
}
