import 'package:flutter/cupertino.dart';

class TableScreen2 extends StatelessWidget {
  final int reward;
  final bool isCash;

  TableScreen2({
    required this.reward,
    required this.isCash,
  });

  String isCashType(bool isCash) {
    if (isCash == true){
      return "현금결제";
    }
    else{
      return "계좌이체";
    }
  }

  late final List<Map<String, dynamic>> list = [
    {
      'text': "심부름 값",
      'content': "${reward} 원",
    },
    {
      'text': "결제 방법",
      'content': isCashType(isCash),
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

    // 금액 및 결제 표
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
        children: List.generate(2, (index) {
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