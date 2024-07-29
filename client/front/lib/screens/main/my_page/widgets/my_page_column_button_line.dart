import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnButtonLine extends StatelessWidget {

  const ColumnButtonLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.w,
      height: 0.5.h,
      decoration: BoxDecoration(
        color: Color(0xffA9A9A9),
      ),
    );
  }
}