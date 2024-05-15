import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

// 환경변수 .env 로드
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
}