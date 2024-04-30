import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sign_up_success.dart';

//현재 화면에서 뒤로가기
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _ProfileScreenState extends State<ProfileScreen> {
  final int minNicknameLength = 2; // 닉네임 최소 길이 설정
  final int maxNicknameLength = 12; // 닉네임 최대 길이 설정
  final int minPasswordLength = 8; // 비밀번호 최소 길이 설정
  final int maxPasswordLength = 20; // 비밀번호 최대 길이 설정
  final int minPasswordCheckLength = 8; // 비밀번호 확인 최소 길이 설정
  final int maxPasswordCheckLength = 20; // 비밀번호 확인 최대 길이 설정

  TextEditingController nicknameController = TextEditingController(); // 닉네임 입력란의 상태 관리 -> 중복확인
  TextEditingController passwordController = TextEditingController(); // 비밀번호 입력란의 상태 관리
  TextEditingController passwordCheckController = TextEditingController(); // 비밀번호 확인 입력란의 상태 관리
  bool isNicknameButtonClickable = false; // 중복 확인 버튼 상태 = 비활성화
  bool isPasswordEnabled = false;
  bool isPasswordButtonVisible = false; // 비밀번호 버튼 눈
  bool isPasswordCheckEnabled = false;
  bool isPasswordCheckButtonVisible = false; // 비밀번호 확인 버튼 눈
  bool isPasswordCheckButtonEnabled = false; // 비밀번호 확인 버튼

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 닉네임 입력란의 상태 변화 감지
    super.initState();
    nicknameController.addListener(updateNicknameButtonState);
    passwordCheckController.addListener(updatePasswordCheckButtonState);
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 호출됨
    nicknameController.dispose();
    passwordCheckController.dispose();
    super.dispose();
  }

  // 닉네임 확인
  void updateNicknameButtonState() {
    // 중복확인 입력란의 텍스트 변경 감지하여 이메일 전성 버튼의 활성화 상태 업데이트
    setState(() {
      isNicknameButtonClickable = nicknameController.text.isNotEmpty;
    });
  }

  void updatePasswordCheckButtonState() {
    // 비밀번호 확인 입력란의 텍스트 변경 감지하여 확인 버튼의 활성화 상태 업데이트
    setState(() {
      isPasswordCheckButtonEnabled = passwordCheckController.text.isNotEmpty;
    });
  }

  //유효성 검증
  bool isValidNickname(String nickname) {
    // 영문, 한글을 포함한 2~12자리, 공백 및 특수문자 불가능
    final RegExp nicknameRegex = RegExp(r'^[a-zA-Zㄱ-ㅎ가-힣]{2,12}$');
    return nicknameRegex.hasMatch(nickname);
  }
  
  String nicknameAvailableText = "중복 확인 버튼을 눌러주세요.";

  bool isNicknameAvailable(String nickname){
    return nickname != "suhyun113"; // 입력된 닉네임이 '심심이'가 아니면 사용 가능한 닉네임
    // 값이 true -> 다름 -> 사용 가능 메시지/ 값이 false -> 같음 -> 사용 불가, 다시 입력 필요
  }
  // 사용자가 입력한 닉네임과 기존에 존재하던 닉네임과 중복 비교
  void checkNicknameAvailable(){
    String enteredNickname = nicknameController.text;
    bool isAvailable = isNicknameAvailable(enteredNickname); // 사용자가 입력한 닉네임을 심심이와 비교

    setState(() {
      // 닉네임 사용 가능 -> 사용 가능 메시지 출력 -> 중복 확인 버튼 비활성화 -> 비밀번호 텍스트 필드 입력 가능
      if (isValidNickname(enteredNickname) && isAvailable){
        isNicknameButtonClickable = true; // 더 이상 중복 확인 필요 없음
        nicknameAvailableText = "사용 가능한 닉네임이에요.";
      // 닉네임 사용 불가 -> 사용 불가 메시지 출력 -> 비밀번호 입력 불가
      } else {
        isNicknameButtonClickable = false;
        nicknameAvailableText = "사용이 어려운 닉네임이에요.";
      }
    });
  }

  bool CheckPassword() {
    return passwordController.text == passwordCheckController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 26.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 26.0),
          child: SizedBox(
            height: 25.0,
            child: Text(
              '회원정보',
              style: TextStyle(
                color: Color(0xFF111111),
                fontFamily: 'Paybooc',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.grey, //텍스트 박스 만들기
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 5.0),
                ),
              ),
              // 텍스트 박스 속 글자 색 블랙
              child: Container(
                // padding: EdgeInsets.all(40.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 22, top: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "닉네임",
                            style: TextStyle(
                              color: Color(0xFF373737),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 22, top: 4.26),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "영문, 한글을 포함한 2~12자리로 입력해 주세요. (공백 및 특수문자 불가)",
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 9.74),
                        // 전체 마진
                        width: 321,
                        // 245 + 9.98 + 66.02
                        height: 38,
                        // 텍스트 필드의 높이 설정
                        /*child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),*/
                        // 가로 패딩 추가
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 9.98),
                                // 닉네임 텍스트 필드와 중복확인 버튼 사이의 간격
                                child: TextField(
                                  maxLength: maxNicknameLength, // 최대 길이 설정
                                  onChanged: (text) {
                                    if (text.length < minNicknameLength) {
                                      print(
                                          '최소 $minNicknameLength자 이상 입력해주세요.');
                                    } else if (text.length > maxNicknameLength) {
                                      print('최대 $maxNicknameLength자만 입력할 수 있습니다.');
                                    }
                                  },
                                  controller: nicknameController, //추가함
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    labelStyle: TextStyle(
                                        color: Color(0xFF404040),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w400),
                                    contentPadding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    // 텍스트를 수직으로 가운데 정렬
                                    border: InputBorder.none,
                                    // 밑줄 없애기
                                    /*         suffixStyle: TextStyle(fontSize: 16),*/
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Color(0xFFACACAC),
                                          width: 0.5 // 테두리 굵기
                                          ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Color(0xFFACACAC),
                                          width: 0.5 // 테두리 굵기
                                          ),
                                    ),
                                    counterText: '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                                  ),
                                  keyboardType: TextInputType.emailAddress,

                                  // onChanged: (value){
                                  //   updateNicknameButtonState();
                                  //   checkNicknameAvailable(); // 닉네임의 사용 가능 여부 확인
                                  //   },

                                ),
                              ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)
                            ),
                            Container(
                              width: 66.02,
                              // height: 38,
                              child: ElevatedButton(
                                onPressed: isNicknameButtonClickable
                                  ? () {
                                  // 버튼이 클릭되었을 때 수행할 작업을 추가합니다.
                                  print('중복입니다! 다시 입력해주세요.');
                                  checkNicknameAvailable(); // 비교해서 메시지 출력
                                  // apt
                                  setState(() {
                                    isPasswordEnabled = true; // 닉네임 중복 확인 버튼 비활성화 + 메시지 색깔이 초록색일 때,
                                  });
                                }
                                : null,
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      EdgeInsets.all(10.01)),

                                  backgroundColor: isNicknameButtonClickable // 텍스트 지우면 다시 비활성화 되도록 만들기
                                      ? MaterialStateProperty.all<Color>(
                                      Color(0xFF7C3D1A))
                                      : MaterialStateProperty.all<Color>(
                                      Color(0xFFBD9E8C)),

                                  // 버튼의 크기 설정
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(66.02, 38)),
                                  // 버튼의 모양 변경
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '중복확인',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 중복확인 버튼 클릭 시, 출력
                      Container(
                        margin: EdgeInsets.only(left: 22, top: 6.5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            nicknameAvailableText,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              color: isNicknameButtonClickable ? Color(0XFF2BBD28): Color(0XFFE33939),
                            ),
                          ),
                        ),
                      ),
                      // 텍스트 위치를 어떻게 앞으로 당기지?

                      Container(
                        margin: EdgeInsets.only(left: 22, top: 10.5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "비밀번호",
                            style: TextStyle(
                              color: Color(0xFF373737),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 22, top: 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '영문 대문자, 소문자, 특수부호를 포함하여 8~20자로 입력해주세요.',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: 320,
                        height: 38,
                        // 텍스트 필드의 높이 설정
                        /*child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),*/
                        // 가로 패딩 추가
                        child: TextField(
                          maxLength: maxPasswordLength, // 최대 길이 설정
                          onChanged: (text) {
                            if (text.length < minPasswordLength) {
                              print(
                                  '최소 $minPasswordLength자 이상 입력해주세요.');
                            } else if (text.length > maxPasswordLength) {
                              print('최대 $maxPasswordLength자만 입력할 수 있습니다.');
                            }
                          },
                          controller: passwordController,
                          obscureText: !isPasswordButtonVisible,
                          // 비밀번호 가리기/보이기 설정

                          decoration: InputDecoration(
                            /* labelText: '학번',*/
                            hintStyle: TextStyle(fontSize: 10),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            labelStyle: TextStyle(
                                color: Color(0xFF404040),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.only(left: 11.58),
                            // 텍스트를 수직으로 가운데 정렬
                            border: InputBorder.none,
                            // 밑줄 없애기
/*                                border: InputBorder.none, // 테두리 없애기*/

                            /*         suffixStyle: TextStyle(fontSize: 16),*/
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordButtonVisible =
                                      !isPasswordButtonVisible; // 상태를 반전시켜서 눈모양 버튼을 클릭할 때마다 비밀번호 보이기/가리기 토글
                                });
                              },
                              icon: isPasswordButtonVisible
                                  ? Image.asset('assets/images/open eye.png')
                                  : Image.asset(
                                      'assets/images/close eye.png'), // 이미지 아이콘 설정
                            ),
                            counterText: '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                          ),
                          keyboardType: TextInputType.text,
                          enabled: isPasswordEnabled,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 24, top: 25),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "비밀번호 확인",
                            style: TextStyle(
                              color: Color(0xFF373737),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 9),
                        width: 320,
                        height: 38,
                        // 텍스트 필드의 높이 설정
                        /*child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),*/
                        // 가로 패딩 추가
                        child: TextField(
                          maxLength: maxPasswordCheckLength, // 최대 길이 설정
                          onChanged: (text) {
                            if (text.length < minPasswordCheckLength) {
                              print(
                                  '최소 $minPasswordCheckLength자 이상 입력해주세요.');
                            } else if (text.length > maxPasswordCheckLength) {
                              print('최대 $maxPasswordCheckLength자만 입력할 수 있습니다.');
                            }
                          },
                          controller: passwordCheckController,
                          obscureText: !isPasswordCheckButtonVisible,
                          // 비밀번호 확인 가리기/보이기 설정

                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 10),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            labelStyle: TextStyle(
                                color: Color(0xFF404040),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.only(left: 11.58),
                            // 텍스트를 수직으로 가운데 정렬
                            border: InputBorder.none,
                            // 밑줄 없애기

                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                                  ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordCheckButtonVisible =
                                      !isPasswordCheckButtonVisible; // 상태를 반전시켜서 눈모양 버튼을 클릭할 때마다 비밀번호 보이기/가리기 토글
                                });
                              },
                              icon: isPasswordCheckButtonVisible
                                  ? Image.asset('assets/images/open eye.png')
                                  : Image.asset(
                                      'assets/images/close eye.png'), // 이미지 아이콘 설정
                            ),
                            counterText: '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)

                      Container(
                        margin: EdgeInsets.only(top: 33),
                        width: 320,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: isPasswordCheckButtonEnabled
                              ? () {
                                  // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                  print('doubleCheck Button Clicked!');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Signup_Success(),
                                    ),
                                  );
                                }
                              : null,
                          style: ButtonStyle(
                            // 버튼의 배경색 변경하기
                            backgroundColor: isPasswordCheckButtonEnabled
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFF7C3D1A))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFBD9E8C)),
                            /*backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),*/
                            // 0xFF로 시작하는 16진수 색상 코드 사용,
                            // 버튼의 크기 정하기
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(320, 40)),
                            // 버튼의 모양 변경하기
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // 원하는 모양에 따라 BorderRadius 조절
                              ),
                            ),
                          ),
                          child: Text(
                            '완료',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
