import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:front/screens/sign_up/utils/class/user.dart';
import 'package:front/screens/sign_up/utils/func/extract_info_from_text.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

String parsedText = ''; // 추출된 텍스트를 저장할 String 변수
User u1 = User('','','','','','');
parseTheText(String mail) async {
  try {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile == null) return;
    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {
      "base64Image": "data:image/png;base64,${img64.toString()}",
      "language": "kor"
    };
    var header = {"apikey": "K88159020988957"};

    var post = await http.post(
        Uri.parse(url), body: payload, headers: header);
    var result = jsonDecode(post.body); // 추출 결과를 받아서 result에 저장

      parsedText = result['ParsedResults'][0]['ParsedText']; // 추출결과를 다시 parsedtext로 저장
      u1 = extractInfoFromText(parsedText, mail)!;
    }
   catch(e) {
    log("error at picked image or connect OCR api");
    u1 = User(mail,'','','','','');
  }
}