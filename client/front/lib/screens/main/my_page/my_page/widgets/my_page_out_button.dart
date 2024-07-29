import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  const OutButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Color(0xff7E7E7E),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400, // Regular
                  fontFamily: "Pretendard",
                  letterSpacing: 0.001,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}