import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/screens/main/utils/class/inprogress_errand.dart';
import 'package:front/screens/main/utils/class/post.dart';
import 'package:front/screens/main/utils/set_button_colors.dart';
import 'package:front/screens/main/widgets/button/filter_button.dart';
import 'package:front/screens/main/widgets/inprogress_widget.dart';
import 'package:front/screens/main/widgets/post_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'check_errand/check_errand.dart';
import '../../login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/widgets/bar/navigation_bar.dart';
const storage = FlutterSecureStorage();
OverlayEntry? overlayEntry;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> errands = [];
  late double latitude;
  late double longitude;
  bool button1state = true; //초기 설정 값
  bool button2state = false;
  bool button3state = false;
  bool isCheckBox = false;
  String status = "";
  String? token = "";
  bool isVisible = false; //쿼카 아이콘 옆 빨간점
  Future<Position> getCurrentLocation() async {
    log("call geolocator");
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log("get position at geolocator");
      return position;

    } catch(e) {
      log("exception: $e");
      return Future.error("faild Geolocator");
    }
  }
  inProgressExist() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/in-progress/exist";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
     if (kDebugMode) {
       print("inprogress exist");
     }
      setState(() {
        isVisible = true;
      });
    }
    else {
      if (kDebugMode) {
        print("no one");
      }
      setState(() {
        isVisible = false;
      });
    }
  }
  inProgressErrandInit() async{
    errands.clear();
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/in-progress";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        InProgressErrand e1 = InProgressErrand.fromJson(item);
        errands.add({
          "errandNo": e1.errandNo,
          "title": e1.title,
          "due": e1.due,
          "isUserOrder": e1.isUserOrder,
        });
        if (kDebugMode) {
          print('inprogress errand init 200');
        }
      }
      setState(() {});
    }
    else {
      if (kDebugMode) {
        print("진행중인 심부름 없음");
      }
    }
  }
  errandLatestInit() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/latest?pk=-1&cursor=3000-01-01 00:00:00.000000&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
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
  errandRewardInit() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/reward?pk=-1&cursor=1000000&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        if (kDebugMode) {
          print('200');
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
  errandDistanceInit() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/distance?cursor=-1&latitude=$latitude&longitude=$longitude&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "distance": p1.distance,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
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
  errandLatestAdd() async{
    Map<String, dynamic> lastPost = posts.last;
    int lasterrandNo = lastPost['errandNo'];
    String lastcreatedDate = lastPost['createdDate'];
    String lastCreatedDate = utf8.decode(lastcreatedDate.runes.toList());
    if (kDebugMode) {
      print(lasterrandNo);
      print(lastCreatedDate);
    }
    token = await storage.read(key: 'TOKEN');
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/latest?pk=$lasterrandNo&cursor=$lastCreatedDate&limit=12&status=$status";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        if (kDebugMode) {
          print('200');
          print(lasterrandNo);
          print(lastCreatedDate);
        }
      }
      setState(() {
      });
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
  errandRewardAdd() async{
    Map<String, dynamic> lastPost = posts.last;
    int lasterrandNo = lastPost['errandNo'];
    int lastreward = lastPost['reward'];
    if (kDebugMode) {
      print(lasterrandNo);
      print(lastreward);
    }
    token = await storage.read(key: 'TOKEN');
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    String url = "${baseUrl}errand/reward?pk=$lasterrandNo&cursor=$lastreward&limit=12&status=$status";
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "createdDate": p1.createdDate,
          "distance": -1.0,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
        });
        if (kDebugMode) {
          print('200');
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
  errandDistanceAdd() async{
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    Map<String, dynamic> lastPost = posts.last;
    String lastdistance = lastPost['distance'];
    String url = "${baseUrl}errand/distance?cursor=$lastdistance&latitude=$latitude&longitude=$longitude&limit=12&status=$status";
    token = await storage.read(key: 'TOKEN');
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "$token"});
    if(response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      for (var item in result) {
        Post p1 = Post.fromJson(item);
        posts.add({
          "orderNo": p1.o1.orderNo,
          "nickname": p1.o1.nickname,
          "score": p1.o1.score,
          "errandNo": p1.errandNo,
          "distance": p1.distance,
          "createdDate": p1.createdDate,
          "title": p1.title,
          "destination": p1.destination,
          "reward": p1.reward,
          "status": p1.status,
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

  final ScrollController _scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((_) {
      insertOverlay(context);
      getCurrentLocation().then((position) {
        setState(() {
          latitude = position.latitude;
          longitude = position.longitude;
        });
      });
    });
    errandLatestInit(); //최신순 요청서 12개
    inProgressExist(); //진행중인 심부름이 있는지 확인
    inProgressErrandInit(); //진행중인 심부름 목록 불러오기
    _scrollController.addListener((){
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) //스크롤을 끝까지 내리면
          {
        setState(() {
          if(button1state)
           {
              errandLatestAdd(); //최신순 요청서 12개
           }
           else if(button2state)
           {
               errandRewardAdd(); //금액순 요청서 12개
           }
           else if(button3state)
           {
             errandDistanceAdd();
           }
          inProgressExist(); //진행중인 심부름이 있는지 확인
          inProgressErrandInit(); //진행중인 심부름 목록 불러오기
        });
      }
    });
  }
  @override
  void dispose(){
    overlayEntry?.remove();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo( // 애니메이션과 함께 맨 위로 스크롤
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }
  Color button1TextColor = const Color(0xff7C2E1A); //초기 색상 값
  Color button1BorderColor = const Color(0xff7C3D1A);
  Color button2TextColor = const Color(0xff4A4A4A);
  Color button2BorderColor = const Color(0xffB1B1B1);
  Color button3TextColor = const Color(0xff4A4A4A);
  Color button3BorderColor = const Color(0xffB1B1B1);
  Color checkboxTextColor = const Color(0xff606060);

  void updateButtonState() { //버튼 상태와 현재 색을 입력 하면
    setState(() { //변경된 색으로 상태를 update 해줌
      changeButtonState(
        button1state: button1state,
        button2state: button2state,
        button3state: button3state,
        setButton1TextColor: (color) => button1TextColor = color,
        setButton1BorderColor: (color) => button1BorderColor = color,
        setButton2TextColor: (color) => button2TextColor = color,
        setButton2BorderColor: (color) => button2BorderColor = color,
        setButton3TextColor: (color) => button3TextColor = color,
        setButton3BorderColor: (color) => button3BorderColor = color,
      );
    });
  }

  void changeCheckboxState()
  {
    setState(() {
      if(isCheckBox)
        {
          checkboxTextColor = const Color(0xff292929);
          status = "RECRUITING";
        }

      else
        {
          checkboxTextColor = const Color(0xff606060);
          status = "";
        }
    });
  }

  // 종료 버튼
  Future<bool?> _showExitDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: const Color(0xffB6B6B6), width: 1.w),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: 323.w,
              height: 214.h,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.h, ),
                    child:  Icon(
                      Icons.exit_to_app,
                      color: const Color(0xffA98474),
                      size: 40.sp,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.h, ),
                    child: Text(
                      "정말 커카를 종료하시겠어요?",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.04,
                        color: const Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16.w, ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18.w, 45.h)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: Text(
                              "종료",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                letterSpacing: 0.00,
                                color: const Color(0xffFFFFFF),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16.w, ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffFFFFFF)),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18.w, 45.h)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: const Color(0xff999999), // 테두리 색상
                                      width: 1.w // 테두리 두께
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              "취소",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                letterSpacing: 0.00,
                                color: const Color(0xff3E3E3E),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
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
      },
    );
  }

  // 로그아웃 버튼
  Future<bool?> _showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: const Color(0xffB6B6B6), width: 1.w),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: 323.w,
              height: 214.h,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF), //배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.h, ),
                    child:  Icon(
                      Icons.logout,
                      color: const Color(0xffA98474),
                      size: 40.sp,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12.h, ),
                    child: Text(
                      "로그아웃 하시겠어요?",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.04,
                        color: const Color(0xff1A1A1A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16.w, ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF7C3D1A)), // 0xFF로 시작하는 16진수 색상 코드 사용,
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18.w, 45.h)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            child: Text(
                              "로그아웃",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                letterSpacing: 0.00,
                                color: const Color(0xffFFFFFF),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                              await storage.delete(key: 'TOKEN');
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16.w, ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffFFFFFF)),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(134.18.w, 45.h)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: const Color(0xff999999), // 테두리 색상
                                      width: 1.w // 테두리 두께
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              "취소",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                letterSpacing: 0.00,
                                color: const Color(0xff3E3E3E),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showExitDialog() ?? false;
        if (context.mounted && shouldPop) {
            SystemNavigator.pop();
        }
      },
      child: Scaffold(
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(width: 57.0.w, height: 25.0.h,
                        margin: EdgeInsets.only(
                            left: 27.w,
                            top: 33.h, ),
                        child: Text(
                          '게시글',
                          style: TextStyle(
                            fontFamily: 'paybooc',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.01,
                            color: const Color(0xff111111),
                          ),),),
                     // SizedBox(width: 194),
                      SizedBox(width: 157.w, ),
                      Container(width: 23.0.w, height: 21.91.h,
                        margin: EdgeInsets.only(top: 29.h, right: 14.w,),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed:
                              () {
                            _showLogoutDialog();
                              },
                          icon: Icon(
                            Icons.logout,
                            color: const Color(0xffB4B5BE),
                            size: 28.sp,
                          ),
                        ),
                      ),
                       Container(width: 23.0.w, height: 21.91.h,
                        margin: EdgeInsets.only(top: 35.h, right: 14.w,),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed:
                              () {},
                          icon: SvgPicture.asset('assets/images/search_icon.svg',
                            color: const Color(0xffB4B5BE),
                          ),
                        ),
                      ),
                      Container(width: 23.0.w, height: 21.91.h,
                        margin: EdgeInsets.only(top: 34.h, right: 21.31.w,),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/images/alarm_icon.svg',
                            color: const Color(0xffB4B5BE),
                          ),
                        ),)
                    ],
                  ),
                    Row(
                      children: [
                        SizedBox(width: 16.w),
                        GestureDetector( //버튼1
                          onTap: () {
                            button1state = true;
                            button2state = false;
                            button3state = false;
                            updateButtonState();
                            posts.clear();
                            errandLatestInit();
                            inProgressExist();
                            inProgressErrandInit();
                            scrollToTop();
                          },
                          child: filterButton1(
                              button1BorderColor,
                              button1TextColor,
                              '최신순'
                          ),
                        ),
                        GestureDetector( //버튼2
                          onTap: () {
                            button1state = false;
                            button2state = true;
                            button3state = false;
                            updateButtonState();
                            posts.clear();
                            errandRewardInit();
                            inProgressExist();
                            inProgressErrandInit();
                            scrollToTop();
                          },
                          child: filterButton1(
                              button2BorderColor,
                              button2TextColor,
                              '금액순'
                          ),
                        ),
                        GestureDetector( //버튼3
                          onTap: () {
                            button1state = false;
                            button2state = false;
                            button3state = true;
                            updateButtonState();
                            posts.clear();
                            errandDistanceInit();
                            inProgressExist();
                            inProgressErrandInit();
                            scrollToTop();
                          },
                          child: filterButton1(
                              button3BorderColor,
                              button3TextColor,
                              '거리순'
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(width: 20.w, height: 20.h,
                          margin: EdgeInsets.only(
                              left: 27.w,
                              top: 16.36.h,
                          ),
                          child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) =>
                                  BorderSide(
                                      width: 1.0.w, color: const Color(0xffC5C5C5)),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            activeColor: const Color(0xffA97651),
                            value: isCheckBox,
                            onChanged: (value) {
                              setState(() {
                                isCheckBox = value!;
                                changeCheckboxState();
                                posts.clear();
                                if (button1state) {
                                    errandLatestInit();
                                }
                                else if (button2state) {
                                  errandRewardInit();
                                }
                                else if(button3state) {
                                  errandDistanceInit();
                                }
                              });
                            },
                          ),
                        ),
                        Container(height: 17.w,
                          margin: EdgeInsets.only(
                              left:2.28.w,
                              top: 14.86.h,
                          ),
                          child: Text('모집 중 모아보기', style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            letterSpacing: 0.001,
                            color: checkboxTextColor,
                          ),),
                        ),
                      ],
                    ),
                  SizedBox(height: 16.36.h, ),
                  Flexible(
                    child: Container(width: 322.w, height: 581.h,
                      //게시글 큰틀
                      margin: EdgeInsets.only(left: 19.w, ),
                      decoration: const BoxDecoration(
                        color: Color(0xffFFFFFF),
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 0.1.h, bottom: 45.h,),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            String nickname = posts[index]["nickname"];
                            String title = posts[index]['title'];
                            String destination = posts[index]['destination'];
                            String createdDate = posts[index]["createdDate"];
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainErrandCheck(
                                              errandNo: posts[index]["errandNo"])
                                  ),);
                              },
                              child: PostWidget(
                                orderNo: posts[index]["orderNo"],
                                nickname: decodedNickname,
                                score: posts[index]["score"],
                                errandNo: posts[index]["errandNo"],
                                createdDate: decodedCreatedDate,
                                distance: posts[index]["distance"],
                                title: decodedTitle,
                                destination: decodedDestination,
                                reward: posts[index]["reward"],
                                status: posts[index]["status"],
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 84.h,
              right: 7.w,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 55.w, height: 55.h,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 389.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF2F2F2),
                                  border: Border(
                                    top: BorderSide(
                                        width: 0.5.w, color: Colors.grey),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 13.47.h,
                                      left: 127.74.w,
                                      child: Container(
                                        width: 104.51.w,
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffAEAEAE),
                                          border: Border.all(
                                            width: 5.w,
                                            color: const Color(0xffAEAEAE),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 42.64.h,
                                      left: 19.64.w,
                                      child: Text(
                                        '메세지를 보낼 심부름 상대를 골라주세요',
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: const Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 85.39.h,
                                      child: Container(
                                        width: 360.w,
                                        height: 310.14.h,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          border: Border(
                                            top: BorderSide(width: 0.1),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: errands.isEmpty
                                            ? const Center(
                                            child: Text("진행중인 심부름이 없습니다."))
                                            : ListView.builder(
                                          padding: EdgeInsets.only(
                                              top: 23.98.h,
                                              bottom: 50.h,
                                          ),
                                          itemCount: errands.length,
                                          itemBuilder: (context, index) {
                                            String decodedTitle = utf8.decode(
                                                errands[index]["title"].runes
                                                    .toList());
                                            String decodedDue = utf8.decode(
                                                errands[index]["due"].runes
                                                    .toList());
                                            return InProgressErrandWidget(
                                              errandNo: errands[index]["errandNo"],
                                              title: decodedTitle,
                                              due: decodedDue,
                                              isUserOrder: errands[index]["isUserOrder"],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: SvgPicture.asset('assets/images/errand_popup_quokka.svg',width: 56.w,
                            height: 56.h,
                            fit: BoxFit.cover),
                      ),),
                    Container(
                      width: 12.w, height: 12.h,
                      margin: EdgeInsets.only(bottom: 42.86.h, ),
                      child: Visibility(
                        visible: isVisible,
                        child: SvgPicture.asset(
                            'assets/images/red_dot_alarm.svg', width: 10.w,
                            height: 10.h,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ]
              ),
            ),
          ],
          )
      )
    );
  }
}

