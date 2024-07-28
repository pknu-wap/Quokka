import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_page_column_toggle_button.dart';

class ColumnButton extends StatefulWidget {
  final String columnButtonText;
  final VoidCallback onTap;
  final bool hasToggle;
  final bool initialToggleValue;

  const ColumnButton({
    Key? key,
    required this.columnButtonText,
    required this.onTap,
    this.hasToggle = false,
    this.initialToggleValue = false,
  }) : super(key: key);

  @override
  _ColumnButtonState createState() => _ColumnButtonState();
}

class _ColumnButtonState extends State<ColumnButton> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.initialToggleValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 304.w,
        height: 50.h,
        padding: EdgeInsets.only(left: 16.w, right: 8.w),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.columnButtonText,
              style: TextStyle(
                color: Color(0xff373737),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400, // Regular
                fontFamily: "Pretendard",
                letterSpacing: 0.00,
              ),
            ),
            if (widget.hasToggle)
              ColumnToggleButton(
                initialToggleValue: widget.initialToggleValue,
                onToggleChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}