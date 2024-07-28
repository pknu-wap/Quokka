import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';

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
              child: greyText(buttonText, 10.sp),
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