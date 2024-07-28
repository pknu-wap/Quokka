import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';

class RowButton extends StatelessWidget {
  final String rowButtonText;
  final String rowButtonIcon;
  final VoidCallback onTap;

  const RowButton({
    Key? key,
    required this.rowButtonText,
    required this.rowButtonIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 79.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: greyText(rowButtonText, 10.sp),
            ),
            SizedBox(height: 8.h),
            Container(
              child: SvgPicture.asset(
                rowButtonIcon,
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