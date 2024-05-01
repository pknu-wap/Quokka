import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front/upload_image.dart';
import 'sign_up_success.dart';

//현재 화면에서 뒤로가기
class ProfileScreen extends StatefulWidget {
  final User u1;
  ProfileScreen( {Key? key, required this.u1, }): super (key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

// 텍스트 필드에 입력하지 않았을 때, 버튼 비활성화 만들기
class _ProfileScreenState extends State<ProfileScreen> {
  late User u1;
  String nicknameText = ""; // 닉네임 오류 메시지
  Color nicknameTextColor = Color(0xFF404040);

  String passwordText = ""; // 비밀번호 오류 메시지
  Color passwordTextColor = Color(0xFF404040); // 비밀번호 오류 메시지 색깔 설정
  Color passwordFilledColor = Color(0xFFF0F0F0); // 텍스트 필드 색깔
  Color passwordFontColor = Color(0xFFF0F0F0); // 텍스트 필드 속 텍스트 색깔
  Color passwordBorderColor = Color(0xFFACACAC); //테두리 색깔

  String passwordCheckText = "";
  // 바로 오류 메시지 띄우기
  Color passwordCheckTextColor = Color(0xFF404040);
  Color passwordCheckFilledColor = Color(0xFFF0F0F0);
  Color passwordCheckFontColor = Color(0xFFF0F0F0);
  Color passwordCheckBorderColor = Color(0xFFACACAC);

  final int minNicknameLength = 2; // 닉네임 최소 길이 설정
  final int maxNicknameLength = 12; // 닉네임 최대 길이 설정
  final int minPasswordLength = 8; // 비밀번호 최소 길이 설정
  final int maxPasswordLength = 20; // 비밀번호 최대 길이 설정
  final int minPasswordCheckLength = 8; // 비밀번호 확인 최소 길이 설정
  final int maxPasswordCheckLength = 20; // 비밀번호 확인 최대 길이 설정

  TextEditingController nicknameController =
  TextEditingController(); // 닉네임 입력란의 상태 관리 -> 중복확인
  TextEditingController passwordController =
  TextEditingController(); // 비밀번호 입력란의 상태 관리
  TextEditingController passwordCheckController =
  TextEditingController(); // 비밀번호 확인 입력란의 상태 관리
  bool isNicknameEnabled = true;
  bool isNicknameButtonClickable = false; // 중복 확인 버튼 상태 = 비활성화
  bool isPasswordEnabled = false;
  bool isPasswordButtonVisible = false; // 비밀번호 버튼 눈
  bool isPasswordCheckEnabled = false;
  bool isPasswordCheckButtonVisible = false; // 비밀번호 확인 버튼 눈
  bool isPasswordCheckButtonEnabled = false; // 비밀번호 확인 버튼
  bool isDuplicateNickname = false;

  @override
  void initState() {
    // 위젯의 초기 상태 설정 = 닉네임 입력란의 상태 변화 감지
    super.initState();
    nicknameController.addListener(updateNicknameButtonState);
    passwordController.addListener(updateNicknameState);
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
      isNicknameButtonClickable = isValidNickname(nicknameController.text);
    });
  }

  void updateNicknameState() {
    setState(() {
      isNicknameEnabled = nicknameController.text.isNotEmpty;
    });
  }

  void updatePasswordCheckButtonState() {
    // 비밀번호 확인 입력란의 텍스트 변경 감지하여 확인 버튼의 활성화 상태 업데이트
    setState(() {
      if (isPasswordEnabled) {
        isPasswordCheckEnabled = true; // 비밀번호 확인 텍스트 필드
        isPasswordCheckButtonEnabled = true; // 비밀번호 확인 버튼
      }
    });
  }

  bool isValidNickname(String nickname){
    // 공백 및 특수문자 제외
    final RegExp nicknameRegex = RegExp(r'^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,12}$');
    return nicknameRegex.hasMatch(nickname);
  }
  bool isNicknameDuplicate(String nickname, String enteredNickname){
    nickname = "suhyun113"; // 기존에 존재하던 닉네임
    enteredNickname = nicknameController.text;

    if(enteredNickname == nickname) return false;
    else return true;
  }

  void checkNicknameAvailable(){
    String enteredNickname = nicknameController.text;
    bool isNicknameAvailable = isValidNickname(enteredNickname);

    setState(() {
      if (isNicknameAvailable) { // 유효성 검사 성공
        nicknameText = "사용이 가능한 닉네임이에요.";
        nicknameTextColor = Color(0xFF2BBD28);
      } else { // 유효성 검사 실패
        nicknameText = "사용이 어려운 닉네임이에요.";
        nicknameTextColor = Color(0xFFE33939);
        // 각 조건에 따른 오류 메시지 출력
      }
    });
  }

  void checkNicknameDuplicate(){
    String nickname = "suhyun113";
    String enteredNickname = nicknameController.text;
    bool isNicknameDuplicated = isNicknameDuplicate(nickname, enteredNickname);

    setState(() {
        // 중복확인 검사
        if (isNicknameDuplicated == false) { // 중복
          nicknameText = "이미 사용하고 있는 닉네임이에요.";
          nicknameTextColor = Color(0xFFE33939);
        }
        else { // 중복x
          nicknameText = "사용 가능한 닉네임이에요.";
          nicknameTextColor = Color(0xFF2BBD28);
        }
    });
  }


  bool isValidPassword1(String password) {
    // 영문 대문자 최소 1개 이상
    final RegExp password1Regex = RegExp(r'^(?=.*[A-Z])');
    return password1Regex.hasMatch(password);
  }

  bool isValidPassword2(String password) {
    // 적어도 영문 소문자 최소 1개 이상
    final RegExp password2Regex = RegExp(r'^(?=.*[a-z])');
    return password2Regex.hasMatch(password);
  }

  bool isValidPassword3(String password) {
    // 숫자 최소 1개 이상
    final RegExp password3Regex = RegExp(r'^(?=.*[\d])');
    return password3Regex.hasMatch(password);
  }

  bool isValidPassword4(String password) {
    // 특수문자 최소 1개 이상
    final RegExp password4Regex = RegExp(r'^(?=.*[`$@!%*#?~^<>,.;:/()&+=])');
    return password4Regex.hasMatch(password);
  }

  bool isValidPassword(String password) {
    // 영문 대문자, 소문자, 숫자, 특수문자 이외의 문자는 입력 불가능
    final RegExp passwordRegex = RegExp(r'^[A-Za-z\d`$@!%*#?~^<>,.;:/()&+=]{8,20}$');
    // final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[`$@!%*#?~^<>,.;:/()&+=])[A-Za-z\d`$@!%*#?~^<>,.;:/()&+=]{8,20}$');
    return passwordRegex.hasMatch(password);
  }

  void checkPasswordAvailable() {
    String enteredPassword = passwordController.text;
    bool isPasswordAvailable = isValidPassword(enteredPassword);
    bool isPassword1Available = isValidPassword1(enteredPassword); // 사용자가 입력한 비밀번호를 유효성 검사하기
    bool isPassword2Available = isValidPassword2(enteredPassword);
    bool isPassword3Available = isValidPassword3(enteredPassword);
    bool isPassword4Available = isValidPassword4(enteredPassword);

    setState(() {
      // 닉네임 사용 가능 -> 사용 가능 메시지 출력 -> 중복 확인 버튼 비활성화 -> 비밀번호 텍스트 필드 입력 가능
      if (isPasswordAvailable) { // 유효성 검사 만족 -> 최소 1개 이상이어야 하는 문자들 검사
        if (!isPassword1Available) {
          passwordText = "영문 대문자가 포함되어야 합니다.";
          passwordTextColor = Color(0xFFE33939);
          passwordFilledColor = Color(0xFFFFDDDD);
          passwordFontColor = Color(0xFFE33939);
          passwordBorderColor = Color(0xFFFA4343);
        } else if (!isPassword2Available) {
          passwordText = "영문 소문자가 포함되어야 합니다.";
          passwordTextColor = Color(0xFFE33939);
          passwordFilledColor = Color(0xFFFFDDDD);
          passwordFontColor = Color(0xFFE33939);
          passwordBorderColor = Color(0xFFFA4343);
        } else if (!isPassword3Available) {
          passwordText = "숫자가 포함되어야 합니다.";
          passwordTextColor = Color(0xFFE33939);
          passwordFilledColor = Color(0xFFFFDDDD);
          passwordFontColor = Color(0xFFE33939);
          passwordBorderColor = Color(0xFFFA4343);
        } else if (!isPassword4Available) {
          passwordText = "특수문자가 포함되어야 합니다.";
          passwordTextColor = Color(0xFFE33939);
          passwordFilledColor = Color(0xFFFFDDDD);
          passwordFontColor = Color(0xFFE33939);
          passwordBorderColor = Color(0xFFFA4343);
        }
        else {
          passwordText = "";
          passwordFilledColor = Color(0xFFF0F0F0);
          passwordFontColor = Color(0xFF969696);
          passwordBorderColor = Color(0xFFACACAC);
        }
      } else { // 사용하면 안 되는 문자 사용
        passwordText = "비밀번호 형식이 올바르지 않아요.";
        // 바로 오류 메시지 띄우기
        passwordTextColor = Color(0xFFE33939);
        passwordFilledColor = Color(0xFFFFDDDD);
        passwordFontColor = Color(0xFFE33939);
        passwordBorderColor = Color(0xFFFA4343);
        // 각 조건에 따른 오류 메시지 출력

      }
    });
  }

  void CheckPassword() {
    bool isPasswordCheckAvailable = passwordController.text == passwordCheckController.text;

    setState(() {
      if (isPasswordCheckAvailable) {
        passwordCheckText = "";
        passwordCheckFilledColor = Color(0xFFF0F0F0);
        passwordCheckFontColor = Color(0xFF969696);
        passwordCheckBorderColor = Color(0xFFACACAC);
        // 학인 버튼 활성화
      } else {
        passwordCheckText = "비밀번호가 일치하지 않아요.";
        // 바로 오류 메시지 띄우기
        passwordCheckTextColor = Color(0xFFE33939);
        passwordCheckFilledColor = Color(0xFFFFDDDD);
        passwordCheckFontColor = Color(0xFFE33939);
        passwordCheckBorderColor = Color(0xFFFA4343);
        // 각 조건에 따른 오류 메시지 출력
      }
    });
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
                            "공백 및 특수문자를 제외한 2~12자로 입력해 주세요.",
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

                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 9.98),
                                // 닉네임 텍스트 필드와 중복확인 버튼 사이의 간격
                                child: TextField(
                                  maxLength: maxNicknameLength,
                                  // 최대 길이 설정
                                  onChanged: (text) {
                                    checkNicknameAvailable(); // 비교해서 메시지 출력

                                    if (text.length < minNicknameLength) {
                                      print(
                                          '최소 $minNicknameLength자 이상 입력해주세요.');
                                    } else if (text.length >
                                        maxNicknameLength) {
                                      print(
                                          '최대 $maxNicknameLength자만 입력할 수 있습니다.');
                                    }
                                  },
                                  controller: nicknameController,
                                  //추가함
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
                                    counterText:
                                    '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                                  ),
                                  keyboardType: TextInputType.emailAddress,
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
                                  checkNicknameDuplicate();
                                }
                                    : null,
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                      EdgeInsets.all(10.01)),

                                  backgroundColor:
                                  isNicknameButtonClickable // 텍스트 지우면 다시 비활성화 되도록 만들기
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

                      // 닉네임 오류 메시지
                      Container(
                        margin: EdgeInsets.only(left: 22, top: 6.5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            nicknameText,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              color: nicknameTextColor

                              // isValidNickname(nicknameController.text) &&
                              //     !isDuplicateNickname
                              //     ? Color(0XFF2BBD28)
                              //     : Color(0XFFE33939),
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
                            '영문 대문자, 소문자, 숫자, 특수문자를 포함하여 8~20자로 입력해주세요.',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.01,
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
                          maxLength: maxPasswordLength,
                          // 최대 길이 설정
                          onChanged: (text) {
                            checkPasswordAvailable(); //체크해서 비밀번호 텍스트 필드 아래에 메시지 출력

                            if (text.length < minPasswordLength) {
                              print('최소 $minPasswordLength자 이상 입력해주세요.');
                            } else if (text.length > maxPasswordLength) {
                              print('최대 $maxPasswordLength자만 입력할 수 있습니다.');
                            }
                          },
                          controller: passwordController,
                          obscureText: !isPasswordButtonVisible,
                          // 비밀번호 가리기/보이기 설정
                          decoration: InputDecoration(
                            errorText: null,
                            // 초기에 오류 메시지 표시x
                            hintStyle: TextStyle(fontSize: 10),
                            filled: true,
                            fillColor: passwordFilledColor,
                            labelStyle: TextStyle(
                                color: passwordFontColor,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.only(left: 11.58),
                            // 텍스트를 수직으로 가운데 정렬
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                              ),
                            ),                              // 밑줄 없애기
                            // 밑줄 없애기
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: passwordBorderColor, width: 0.5 // 테두리 굵기
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
                                  isPasswordButtonVisible = !isPasswordButtonVisible; // 상태를 반전시켜서 눈모양 버튼을 클릭할 때마다 비밀번호 보이기/가리기 토글
                                });
                              },
                              icon: isPasswordButtonVisible
                                  ? Image.asset('assets/images/open eye.png')
                                  : Image.asset(
                                  'assets/images/close eye.png'), // 이미지 아이콘 설정
                            ),
                            counterText:
                            '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                          ),
                          keyboardType: TextInputType.text,
                          enabled: nicknameText == "사용이 가능한 닉네임이에요.",
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 22, top: 7),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            passwordText,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              color: passwordTextColor
                              // color: isValidNickname(nicknameController.text) &&
                              //     !isDuplicateNickname
                              //     ? Color(0XFF2BBD28)
                              //     : Color(0XFFE33939),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 24, top: 4),
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
                          maxLength: maxPasswordCheckLength,
                          // 최대 길이 설정
                          onChanged: (text) {
                            CheckPassword();

                            if (text.length < minPasswordCheckLength) {
                              print('최소 $minPasswordCheckLength자 이상 입력해주세요.');
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
                            fillColor: passwordCheckFilledColor,
                            labelStyle: TextStyle(
                                color: passwordCheckFontColor,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.only(left: 11.58),
                            // 텍스트를 수직으로 가운데 정렬
                            // 밑줄 없애기
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFACACAC), width: 0.5 // 테두리 굵기
                              ),
                            ),                              // 밑줄 없애기
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: passwordCheckBorderColor, width: 0.5 // 테두리 굵기
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
                            counterText:
                            '', // 입력 길이 표시를 없애는 부분 -> 이 코드 없으면 0/9라는 숫자 생김
                          ),
                          keyboardType: TextInputType.text,
                          enabled: passwordText == "",
                        ),
                      ), // 이메일 텍스트 입력 구현(누르면 글자 사라짐)

                      Container(
                        margin: EdgeInsets.only(left: 24, top: 7),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            passwordCheckText,
                            style: TextStyle(
                              color: passwordCheckTextColor,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(top: 33),
                          width: 320,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: passwordCheckText == ""
                                ? () {
                              // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                              if (!isNicknameButtonClickable){
                                nicknameText = "중복 확인 버튼을 눌러주세요.";
                                nicknameTextColor = Color(0xFFE33939);
                              }
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
                              backgroundColor: passwordCheckText == ""
                                  ? MaterialStateProperty.all<Color>(
                                  Color(0xFF7C3D1A))
                                  : MaterialStateProperty.all<Color>(
                                  Color(0xFFBD9E8C)),
                              /*backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),*/
                              // 0xFF로 시작하는 16진수 색상 코드 사용,
                              // 버튼의 크기 정하기
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(320, 40)),
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
                          )),
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