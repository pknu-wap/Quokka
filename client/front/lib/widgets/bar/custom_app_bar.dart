import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  // AppBar와 CustomAppBar 같은 크기 갖도록 함
  final String title;
  final VoidCallback onBackPressed;

  CustomAppBar({
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      leading: Padding(
        padding: EdgeInsets.only(top: 26.0.h),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: onBackPressed,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 26.0.h),
        child: SizedBox(
          height: 25.0.h,
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFF111111),
                fontFamily: 'Paybooc',
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                letterSpacing: 0.01
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


