import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/widgets/text/button_text.dart';

// 흰색 미니 버튼
Widget whiteMiniButton({required String text, required VoidCallback onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
      minimumSize: MaterialStateProperty.all<Size>(Size(134.18.w, 45.h)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Color(0xff999999),
            width: 1.0,
          ),
        ),
      ),
    ),
    child: whiteButtonText(text),
  );
}

// 갈색 미니 버튼
Widget brownMiniButton({required String text, required VoidCallback onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7C3D1A)),
      minimumSize: MaterialStateProperty.all<Size>(Size(134.18.w, 45.h)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    child: buttonText(text),
  );
}