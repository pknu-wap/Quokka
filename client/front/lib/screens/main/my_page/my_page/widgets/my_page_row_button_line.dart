import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowButtonLine extends StatelessWidget {
  final double rowLineHeight;

  const RowButtonLine({
    Key? key,
    required this.rowLineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.w,
      height: rowLineHeight.h,
      decoration: BoxDecoration(
        color: Color(0xffA9A9A9),
      ),
    );
  }
}