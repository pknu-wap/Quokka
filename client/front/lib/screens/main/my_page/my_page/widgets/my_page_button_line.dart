import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLine extends StatelessWidget {

  const ButtonLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.w,
      height: 39.h,
      decoration: BoxDecoration(
        color: Color(0xffA9A9A9),
      ),
    );
  }
}