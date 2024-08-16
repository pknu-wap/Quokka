import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/main/my_page/user_info/my_page_user_info.dart';
import 'package:front/screens/main/my_page/utils/user_info_revision_button_utill.dart';
import 'package:front/widgets/bar/app_bar/custom_app_bar_center.dart';
import 'package:front/widgets/button/brown_button.dart';
import 'user_info_revision_container.dart';

class UserInfoRevision extends StatefulWidget {
  final String nickName;
  final String name;
  final String email;
  final String password;

  UserInfoRevision({
    Key? key,
    required this.nickName,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _UserInfoRevisionState createState() => _UserInfoRevisionState();
}

class _UserInfoRevisionState extends State<UserInfoRevision> {
  late TextEditingController _nickNameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late String _originalNickName;
  late String _originalName;
  late String _originalEmail;
  late String _originalPassword;

  @override
  void initState() {
    super.initState();

    _originalNickName = widget.nickName;
    _originalName = widget.name;
    _originalEmail = widget.email;
    _originalPassword = widget.password;

    _nickNameController = TextEditingController(text: _originalNickName);
    _nameController = TextEditingController(text: _originalName);
    _emailController = TextEditingController(text: _originalEmail);
    _passwordController = TextEditingController(text: _originalPassword);

    _nickNameController.addListener(_checkIfChanged);
    _nameController.addListener(_checkIfChanged);
    _emailController.addListener(_checkIfChanged);
    _passwordController.addListener(_checkIfChanged);
  }

  void _checkIfChanged() {
    setState(() {});
  }

  bool get _isButtonEnabled {
    return _nickNameController.text != _originalNickName ||
        // _nameController.text != _originalName ||
        // _emailController.text != _originalEmail ||
        _passwordController.text != _originalPassword;  // 수정 필요
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCenter(
        title: '회원 정보 수정',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            // 닉네임
            RevisionContainer(
              controller: _nickNameController,
              labelText: '닉네임',
              keyboardType: TextInputType.text,
            ),
            // 이름
            RevisionContainer(
              controller: _nameController,
              labelText: '이름',
              keyboardType: TextInputType.text,
              grayText: "수정이 불가합니다.",
            ),
            SizedBox(
              height: 10.h,
            ),
            // 계정
            RevisionContainer(
              controller: _emailController,
              labelText: '계정',
              keyboardType: TextInputType.emailAddress,
              grayText: "수정이 불가합니다.",
            ),
            SizedBox(
              height: 10.h,
            ),
            // 비밀번호
            RevisionContainer(
              controller: _passwordController,
              labelText: '비밀번호',
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            // 수정 완료 버튼
            Container(
              margin: EdgeInsets.only(left: 23.0.w, right: 19.0.w, top: 38.63.h),
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPageUserInfo(
                        nickName: _nickNameController.text,
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    ),
                  );
                } : null,
                style: brownButton318(decideButtonColor(_isButtonEnabled)),
                child: Text(
                  "수정 완료",
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
  @override
  void dispose() {
    _nickNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
