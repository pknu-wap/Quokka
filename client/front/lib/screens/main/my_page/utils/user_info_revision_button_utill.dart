import 'package:flutter/cupertino.dart';

Color decideButtonColor(bool isButtonEnabled) {
  if (isButtonEnabled)
  {
    return Color(0xFF7C3D1A);
  }
  else
  {
    return Color(0xFFBD9E8C);
  }
}