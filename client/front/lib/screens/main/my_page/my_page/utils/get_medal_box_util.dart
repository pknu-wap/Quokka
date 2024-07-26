// get_medal_box

// 배지 박스 가로 길이
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