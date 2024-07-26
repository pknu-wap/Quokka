// get_medal_box

// 배지 박스 가로 길이
import 'dart:ui';

import 'change_color_util.dart';

double getMedalBoxWidth(int score) {
  String color = changeColor(score);
  switch (color) {
    case "Bronze":
      return 34.0;
    case "Silver":
      return 28.0;
    case "Gold":
      return 25.0;
    case "Purple":
      return 31.0;
    case "Black":
      return 28.0;
    default:
      return 21.0; // 임의로 저장
  }
}

// 배지 박스 fillColor
Color getMedalBoxFillColor(int score){
  String color = changeColor(score);
  switch (color) {
    case "Bronze":
      return Color(0xFFF9B887); // Bronze color
    case "Silver":
      return Color(0xFFDDDFE4); // Silver color
    case "Gold":
      return Color(0xFFFBE4AE); // Gold color
    case "Purple":
      return Color(0xFFB283EC); // Purple color
    case "Black":
      return Color(0xFF111211); // Black color
    default:
      return Color(0xFFD3D3D3); // Default color
  }
}