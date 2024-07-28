import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RowButton extends StatelessWidget {
  final String buttonText;
  final String buttonIcon;
  final VoidCallback onTap;

  const RowButton({
    Key? key,
    required this.buttonText,
    required this.buttonIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 79.h,
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
            SizedBox(height: 8.h),
            Container(
              child: SvgPicture.asset(
                buttonIcon,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}