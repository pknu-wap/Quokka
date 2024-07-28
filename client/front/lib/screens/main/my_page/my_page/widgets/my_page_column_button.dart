import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';

class ColumnButton extends StatelessWidget {
  final String columnButtonText;
  final VoidCallback onTap;

  const ColumnButton({
    Key? key,
    required this.columnButtonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 304.w,
        height: 50.h,
        padding: EdgeInsets.only(left: 16.w),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: listText(columnButtonText),
      ),
    );
  }
}