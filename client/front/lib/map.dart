import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapTest extends StatefulWidget {
  @override
  State<NaverMapTest> createState() => _NaverMapTestState();
}

class _NaverMapTestState extends State<NaverMapTest> {
  TextEditingController destinationController = TextEditingController();
  bool isDestinationEnabled = false;

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
    // 중복확인 입력란의 텍스트 변경 감지하여 버튼의 도착지 활성화 상태 업데이트
    setState(() {
      isDestinationEnabled = destinationController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            // 네이버 지도
            Container(
              margin: EdgeInsets.only(left: 0, top: 25.55),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    width: 318.85,
                    height: 508.67,
                    margin: EdgeInsets.only(left: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NaverMap(
                        options: const NaverMapViewOptions(),
                        onMapReady: (controller) {
                          print("네이버 맵 로딩됨!");
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
