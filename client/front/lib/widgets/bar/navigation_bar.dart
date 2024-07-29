import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screens/main/errand_list/errand_list.dart';
import 'package:front/screens/main/my_page/my_page/my_page.dart';
import 'package:front/screens/main/write_errand/write_errand.dart';

void insertOverlay(BuildContext context) {
  if (overlayEntry != null) return;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 0.h,
      left: 0.w,
      right: 0.w,
      child: Container(
        width: 360.w,
        height: 64.h,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          border: Border.all(
            color: Color(0xffCFCFCF),
            width: 0.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(185, 185, 185, 0.25),
              offset: Offset(5, -1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 22.w,
              height: 22.h,
              margin: EdgeInsets.only(left: 44.w,  top: 20.h, bottom: 17.32.h, ),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()));
                },
                icon: SvgPicture.asset(
                  'assets/images/home_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 19.31.w,
              height: 23.81.h,
              margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPage()));
                },
                icon: SvgPicture.asset(
                  'assets/images/profile_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 22.0.w,
              height: 22.h,
              margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => WriteErrand(),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/images/write_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
            Container(
              width: 21.95.w,
              height: 24.21.h,
              margin: EdgeInsets.only(top: 20.h, bottom: 17.32.h,
                right: 43.92.w, ),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/images/history_icon.svg',
                  color: Color(0xffADADAD),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlayEntry!);
}

void removeOverlay() {
  overlayEntry?.remove();
  overlayEntry = null;
}