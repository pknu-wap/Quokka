import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/my_page_column_button_line.dart';
import 'widgets/user_info_column.dart';

class ColumnList extends StatefulWidget {
  final String nickName;
  final String name;
  final String email;
  final String password;

  ColumnList({
    Key? key,
    required this.nickName,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _ColumnListState createState() => _ColumnListState();
}

class _ColumnListState extends State<ColumnList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 39.h),
      // 상자 만들기
      width: 330.w,
      height: 224.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xffA9A9A9),
            width: 0.5,
          )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 닉네임
            UserInfoColumn(
              textName: "닉네임",
              textInfo: widget.nickName,
            ),
            ColumnButtonLine(),
            // 이름
            UserInfoColumn(
              textName: "이름",
              textInfo: widget.name,
            ),
            ColumnButtonLine(),
            // 계정
            UserInfoColumn(
              textName: "계정",
              textInfo: widget.email,
            ),
            ColumnButtonLine(),
            // 비밀번호
            UserInfoColumn(
              textName: "비밀번호",
              textInfo: widget.password,
              obscureText: true, // 비밀번호 가리기
            ),
          ],
        ),
      ),
    );
  }
}