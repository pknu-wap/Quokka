// change_color

String changeColor(int score) {
  if (0 <= score && score <= 100) {
    return "Bronze";
  } else if (score <= 500) {
    return "Silver";
  } else if (score <= 800) {
    return "Gold";
  } else if (score <= 900) {
    return "Purple";
  } else if (score <= 1000) {
    return "Black";
  }
  return "Default"; // 임의로 저장
}