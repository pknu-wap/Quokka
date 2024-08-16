import 'package:flutter/material.dart';
import 'package:front/screens/main/my_page/user_info_revision/widgets/user_info_revision_text.dart';
import 'package:front/screens/main/my_page/widgets/my_page_text.dart';
import 'widgets/user_info_revision_text_field.dart';

class RevisionContainer extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText; // 텍스트 가리기
  final bool readOnly; // 읽기 전용
  final String grayText;

  const RevisionContainer({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.grayText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 텍스트 필드 이름
        title(labelText),
        // 텍스트 필드(정보)
        RevisionTextField(
          controller: controller,
          text: "",
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
        ),
        // 텍스트 필드 회색 설명 문자
        revisionGrayText(grayText),
      ],
    );
  }
}
