// get_medal_image

// 배지 이미지
import 'change_color_util.dart';

String getMedalImage(int score) {
  String color = changeColor(score);
  switch (color) {
    case "Bronze":
      return 'assets/images/bronze_medal.svg';
    case "Silver":
      return 'assets/images/silver_medal.svg';
    case "Gold":
      return 'assets/images/gold_medal.svg';
    case "Purple":
      return 'assets/images/purple_medal.svg';
    case "Black":
      return 'assets/images/black_medal.svg';
    default:
      return 'assets/images/default_medal.svg'; // 임의로 저장
  }
}