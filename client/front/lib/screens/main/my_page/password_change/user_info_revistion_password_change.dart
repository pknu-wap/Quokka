import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/main/my_page/user_info_revision/user_info_revision.dart';
import 'package:front/screens/main/my_page/utils/user_info_revision_button_utill.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';
import 'package:front/widgets/button/brown_button.dart';
import 'password_change_container.dart';

class PasswordChange extends StatefulWidget {
  final String password; // 현재 비밀번호

  PasswordChange({Key? key, required this.password}) : super(key: key);

  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _passwordCheckController;

  bool _isCurrentPasswordValid = false;
  bool _isNewPasswordValid = false;
  bool _doPasswordsMatch = false;

  String _currentPasswordError = "";
  String _newPasswordError = "";
  String _passwordMatchError = "";

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _passwordCheckController = TextEditingController();

    _currentPasswordController.addListener(_validateCurrentPassword);
    _newPasswordController.addListener(_validateNewPassword);
    _passwordCheckController.addListener(_checkPasswordsMatch);
  }

  void _validateCurrentPassword() { // 현재 비밀번호 유효성 검사
    setState(() {
      String currentPasswordInput = _currentPasswordController.text.trim(); // 공백 제거
      if (currentPasswordInput != widget.password) {
        _isCurrentPasswordValid = false;
        _currentPasswordError = "비밀번호가 맞지 않아요. 다시 입력해 주세요.";
      } else {
        _isCurrentPasswordValid = true;
        _currentPasswordError = "";
      }
      print("Stored password: ${widget.password}");
      print("Entered password: $currentPasswordInput");
    });
  }

  void _validateNewPassword() { // 새로운 비밀번호
    final password = _newPasswordController.text;
    setState(() {
      if (!RegExp(r'[A-Z]').hasMatch(password)) {
        _isNewPasswordValid = false;
        _newPasswordError = "영문 대문자가 포함된 비밀번호로 만들어 주세요.";
      } else if (!RegExp(r'[a-z]').hasMatch(password)) {
        _isNewPasswordValid = false;
        _newPasswordError = "소문자가 포함된 비밀번호로 만들어 주세요.";
      } else if (!RegExp(r'\W').hasMatch(password)) {
        _isNewPasswordValid = false;
        _newPasswordError = "특수문자가 포함된 비밀번호로 만들어 주세요.";
      } else if (password.length < 8 || password.length > 20) {
        _isNewPasswordValid = false;
        _newPasswordError = "8~20자로 입력해 주세요.";
      } else {
        _isNewPasswordValid = true;
        _newPasswordError = "";
      }
    });
  }

  // 새로운 비밀번호와 비밀번호 확인 비교
  void _checkPasswordsMatch() {
    setState(() {
      _doPasswordsMatch = _newPasswordController.text == _passwordCheckController.text;
    });
  }

  bool get _isButtonEnabled {
    return _isCurrentPasswordValid && _isNewPasswordValid && _doPasswordsMatch;
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCenter(
        title: '비밀번호 변경',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Center(
              child: PasswordChangeContainer(
                controller: _currentPasswordController,
                labelText: '현재 비밀번호 입력',
                keyboardType: TextInputType.text,
                obscureText: true,
                grayText: "영문 대문자, 소문자, 특수부호를 포함하여 8~20자로 입력해주세요.",
                borderColor: _isCurrentPasswordValid ? Color(0xffACACAC) : Color(0xffFA4343),
                fillColor: _isCurrentPasswordValid ? Color(0xffF0F0F0) : Color(0xffFFDDDD),
                textColor: _isCurrentPasswordValid ? Color(0xff404040) : Color(0xffCC5C5C),
                errorText: _currentPasswordError,
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: PasswordChangeContainer(
                controller: _newPasswordController,
                labelText: '새로운 비밀번호',
                keyboardType: TextInputType.text,
                obscureText: true,
                enabled: _isCurrentPasswordValid,
                grayText: "영문 대문자, 소문자, 특수부호를 포함하여 8~20자로 입력해주세요.",
                borderColor: _isNewPasswordValid ? Color(0xffACACAC) : Color(0xffFA4343),
                fillColor: _isNewPasswordValid ? Color(0xffF0F0F0) : Color(0xffFFDDDD),
                textColor: _isNewPasswordValid ? Color(0xff404040) : Color(0xffCC5C5C),
                errorText: _newPasswordError,
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: PasswordChangeContainer(
                controller: _passwordCheckController,
                labelText: '비밀번호 확인',
                keyboardType: TextInputType.text,
                obscureText: true,
                enabled: _isCurrentPasswordValid,
                borderColor: _doPasswordsMatch ? Color(0xffACACAC) : Color(0xffFA4343),
                fillColor: _doPasswordsMatch ? Color(0xffF0F0F0) : Color(0xffFFDDDD),
                textColor: _doPasswordsMatch ? Color(0xff404040) : Color(0xffCC5C5C),
                errorText: _doPasswordsMatch ? "" : "비밀번호가 일치하지 않습니다. 다시 입력해주세요.",
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 23.0.w, right: 19.0.w, top: 320.h),
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoRevision(
                        nickName: "",
                        name: "",
                        email: "",
                        password: _passwordCheckController.text, // 변경된 비밀번호
                      ),
                    ),
                  );
                } : null,
                style: brownButton318(decideButtonColor(_isButtonEnabled)),
                child: Text(
                  "변경 완료",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 0.01,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
