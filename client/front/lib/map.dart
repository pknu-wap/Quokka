import 'package:flutter/material.dart'; // icon 사용하기 위해 필요
import 'package:flutter/widgets.dart'; // text컨트롤러 사용하기 위해 필요

//현재 화면에서 뒤로가기
class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _MapState extends State<Map> {
  TextEditingController destinationController = TextEditingController();


  bool isDestinationEnabled = false;  // 텍스트 필드 변수 선언
  bool isCompletedEnabled = false; // 도착지로 설정할게요 버튼

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 상태 변화 감지
    super.initState();
    destinationController.addListener(updateDestinationState);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    destinationController.dispose();
    super.dispose();
  }

  void updateDestinationState() {
    setState(() {
      isDestinationEnabled = destinationController.text.isNotEmpty;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 19.0, top: 34.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      '도착지 찾기',
                      style: TextStyle(
                        fontFamily: 'Paybooc',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111111),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 34),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Text(
                          '제목',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.01,
                            color: Color(0xff111111),
                          ),
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 300),
                      child: Text(
                        '*',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.01,
                          color: Color(0xffF05252),
                        ),
                      ),
                    ),
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
