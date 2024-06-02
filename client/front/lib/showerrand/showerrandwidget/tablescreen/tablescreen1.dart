import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TableScreen1 extends StatelessWidget {
  final String title;
  final String name;
  final String createdDate;
  final String due;
  final String destination;
  final String detail;

  TableScreen1({
    required this.title,
    required this.name,
    required this.createdDate,
    required this.due,
    required this.destination,
    required this.detail,
  });
  late DateTime datetime = DateFormat('yyyy-MM-dd').parse(createdDate); // 요청일 String을 DateTime으로 변환
  // 날짜를 yyyy.MM.dd 형식으로 변환하는 함수
  String formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  late final List<Map<String, dynamic>> list = [
    {
      'text': "제목",
      'content': utf8.decode(title.runes.toList()),
    },
    {
      'text': "글 쓴 사람",
      'content': utf8.decode(name.runes.toList()),
    },
    {
      'text': "요청일",
      'content': formatDate(datetime),
    },
    {
      'text': "일정",
      'content': "${utf8.decode(due.runes.toList())}까지",
    },
    {
      'text': "장소",
      'content': utf8.decode(destination.runes.toList()),
    },
    {
      'text': "요청 사항",
      'content': utf8.decode(detail.runes.toList()),
    }
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle1 = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w300,
      fontSize: 11,
      letterSpacing: 0.001,
      color: Color(0xffFFFFFF),
    );
    final TextStyle textStyle2 = TextStyle(
      fontFamily: 'SANGJUDajungdagam',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      letterSpacing: 0.00,
      color: Color(0xff111111),
    );

    // 심부름 사항 표
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
      child: Table(
        columnWidths: { // 표의 각 너비 조정
          0: FixedColumnWidth(62),
          1: FixedColumnWidth(176),
        },
        border: TableBorder(
          borderRadius: BorderRadius.circular(10),
          horizontalInside: BorderSide(color: Color(0xffF1F1F1), width: 1), // 안 쪽 가로 줄
        ),
        children: List.generate(6, (index) {
          return TableRow(children: [
            TableCell(
              child: Container(
                  height: 30,
                  color: Color(0xff674333),
                  child: Center(child: Text(list[index]['text'], style: textStyle1,))), // 가운데 정렬
            ),
            TableCell(
              child: Container(
                  height: 30,
                  padding: EdgeInsets.only(left: 9, top: 4), // 왼쪽 정렬 띄우기 위함
                  color: Color(0xffFFFFFF),
                  child: Align(
                      alignment: Alignment.centerLeft, // 왼쪽 정렬
                      child: Text(list[index]['content'], style: textStyle2,))),
            ),
          ]);
        }),
       ),
      ),
    );
  }
}