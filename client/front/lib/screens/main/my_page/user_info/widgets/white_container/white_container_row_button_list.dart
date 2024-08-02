import 'package:flutter/material.dart';
import 'white_container_row_button.dart';

class WhiteContainerRowButtonList extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onSave;

  WhiteContainerRowButtonList({
    required this.onReset,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 흰색 미니 버튼
          whiteMiniButton(
            text: '지우기',
            onPressed: onReset,
          ),
          // 갈색 미니 버튼
          brownMiniButton(
            text: '저장',
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}
