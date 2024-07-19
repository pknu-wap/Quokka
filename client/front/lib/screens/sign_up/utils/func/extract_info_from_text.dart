import 'package:front/screens/sign_up/utils/class/user.dart';
import 'package:front/services/sign_up/extract_text_from_img.dart';

User? extractInfoFromText(String parsedText, String mail) {

  int index = parsedText.indexOf('남은시간');
  if(index == -1) {
    index = parsedText.indexOf('남은');
  }
  if(index == -1)
  {
    index = parsedText.indexOf('시간');
  }
  if(index == -1)
  {
    index = parsedText.indexOf('은시');
  }
  if (index != -1) {
    // "남은시간"을 기준으로 분할하여 앞 부분은 잘라냄
    String remainingText = parsedText.substring(index);

    // "\n"을 기준으로 분할하여 리스트로 저장
    List<String> splitText = remainingText.split('\n');

    splitText.removeAt(0); // 첫 번째 요소인 "남은시간: 30"은 필요 없으므로 제거

    // 추출된 텍스트에서 학번, 이름, 전공 추출

    if (splitText.length >= 3) {
      //splitText[0]: 이름, splitText[1]: 전공, splitText[2]: 학번
      return u1 = User(mail,splitText[1],splitText[0],splitText[2],'',''); // s1에 객체 저장
    }

  }
}