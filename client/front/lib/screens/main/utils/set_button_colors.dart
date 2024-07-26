import 'package:flutter/material.dart';

void _setButtonColors({
  required bool state,
  required ValueChanged<Color> setTextColor,
  required ValueChanged<Color> setBorderColor,
}) {
  if (state) {
    setTextColor(const Color(0xff7C2E1A));
    setBorderColor(const Color(0xff7C3D1A));
  } else {
    setTextColor(const Color(0xff4A4A4A));
    setBorderColor(const Color(0xffB1B1B1));
  }
}

void changeButtonState({
  required bool button1state,
  required bool button2state,
  bool? button3state,
  required ValueChanged<Color> setButton1TextColor,
  required ValueChanged<Color> setButton1BorderColor,
  required ValueChanged<Color> setButton2TextColor,
  required ValueChanged<Color> setButton2BorderColor,
  ValueChanged<Color>? setButton3TextColor,
  ValueChanged<Color>? setButton3BorderColor,
}) {
  _setButtonColors(
    state: button1state,
    setTextColor: setButton1TextColor,
    setBorderColor: setButton1BorderColor,
  );

  _setButtonColors(
    state: button2state,
    setTextColor: setButton2TextColor,
    setBorderColor: setButton2BorderColor,
  );
   //버튼이 2개인 경우, 3개인 경우 모두 작동 하도록 설계
  if (button3state != null && setButton3TextColor != null && setButton3BorderColor != null) {
    _setButtonColors(
      state: button3state,
      setTextColor: setButton3TextColor,
      setBorderColor: setButton3BorderColor,
    );
  }
}