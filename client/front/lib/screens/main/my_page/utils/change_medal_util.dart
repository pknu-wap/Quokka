// image change_medal_util

String changeMedal(int score) {
  if (0 <= score && score <= 100) {
    return 'assets/images/bronze_medal.svg';
  } else if (score <= 500) {
    return 'assets/images/silver_medal.svg';
  } else if (score <= 800) {
    return 'assets/images/gold_medal.svg';
  } else if (score <= 900) {
    return 'assets/images/purple_medal.svg';
  } else if (score <= 1000) {
    return 'assets/images/black_medal.svg';
  }
  return 'assets/images/default_medal.svg'; // 임의로 저장
}